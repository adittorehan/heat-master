class AddFeedbackToSurveyResults < ActiveRecord::Migration[5.2]
  def change
    add_column :survey_results, :feedback_answers, :jsonb, default: {}
    add_column :survey_results, :feedback_email, :string, limit: 128
    add_column :survey_results, :feedback_open_answer, :string, limit: 256
  end
end
