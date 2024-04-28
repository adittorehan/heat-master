class AddProblemStatementAnswersToSurveyResults < ActiveRecord::Migration[5.2]
  def change
    add_column :survey_results, :problem_statement_answers, :jsonb, default: {}
    add_column :survey_results, :problem_statement_open_answer, :string, limit: 256
    add_column :survey_results, :solution_statement_answers, :jsonb, default: {}
    add_column :survey_results, :solution_statement_open_answer, :string, limit: 256
  end
end
