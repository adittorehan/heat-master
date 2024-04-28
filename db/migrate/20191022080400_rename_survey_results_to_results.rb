class RenameSurveyResultsToResults < ActiveRecord::Migration[5.2]
  def change
    rename_table :survey_results, :results
  end
end
