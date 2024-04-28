class CreateFeedback < ActiveRecord::Migration[5.2]
  class Survey < ApplicationRecord
    has_one :feedback, dependent: :destroy
  end

  class Feedback < ApplicationRecord
    belongs_to :survey, touch: true
  end

  def feedback_default
    {
      headline: "A few last things",
      subheadline: "Before you're finishing up we want to ask you a few things",
      ask_for_testing: true,
      ask_for_testing_label: "Let us know if you'd like to help out in the one of the following ways:",
      ask_for_testing_options: [
        "Giving online feedback on our next prototype",
        "Participating in a short interview",
        "Participating in a user test"
      ].join("\n"),
      ask_for_email: true,
      ask_for_email_label: "Please leave your e-mail address if you want to be kept updated (we won't share it
                                      with third parties)",
      open_ended_question: true
    }
  end

  def change
    create_table :feedbacks do |t|
      t.references :survey, foreign_key: true
      t.string :headline
      t.string :subheadline
      t.boolean :ask_for_testing, default: true
      t.string :ask_for_testing_label
      t.string :ask_for_testing_options
      t.boolean :ask_for_email, default: true
      t.string :ask_for_email_label
      t.boolean :open_ended_question, default: true

      t.timestamps
    end

    Survey.find_each do |survey|
      survey.create_feedback(feedback_default)
    end
  end
end
