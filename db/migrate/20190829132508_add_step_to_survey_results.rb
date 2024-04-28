class AddStepToSurveyResults < ActiveRecord::Migration[5.2]
  def change
    add_column :survey_results, :step, :integer, default: 1
  end
end
