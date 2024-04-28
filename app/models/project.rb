class Project < ApplicationRecord
  belongs_to :workspace, touch: true
  has_one :survey, dependent: :destroy

  after_save :update_survey_name

  validates :name, presence: true

  def update_survey_name
    return unless saved_change_to_attribute?("name")
    return unless survey.present?

    survey.update(name: name)
  end
end
