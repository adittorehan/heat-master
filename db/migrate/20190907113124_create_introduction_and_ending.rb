class CreateIntroductionAndEnding < ActiveRecord::Migration[5.2]
  class Survey < ApplicationRecord
    has_one :introduction, dependent: :destroy
    has_one :ending, dependent: :destroy
  end

  class Introduction < ApplicationRecord
    belongs_to :survey, touch: true
  end

  class Ending < ApplicationRecord
    belongs_to :survey, touch: true
  end

  def introduction_default
    {
      headline: "Market research",
      subheadline: "We are working on X to help Y do Z. We would like to ask you a couple of questions to help
                    us evaluate the market. We estimate the survey will take no longer than 10 minutes of your
                    time. Thanks!"
    }
  end

  def ending_default
    {
      headline: "Thank you",
      subheadline: "Some text"
    }
  end

  def change
    create_table :introductions do |t|
      t.references :survey, foreign_key: true
      t.string :headline
      t.string :subheadline

      t.timestamps
    end

    create_table :endings do |t|
      t.references :survey, foreign_key: true
      t.string :headline
      t.string :subheadline
      t.boolean :include_sharing, default: true

      t.timestamps
    end

    Survey.find_each do |survey|
      survey.create_introduction(introduction_default)
      survey.create_ending(ending_default)
    end
  end
end
