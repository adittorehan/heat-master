class AddProblemAndSolutionToExistingSurveys < ActiveRecord::Migration[5.2]
  class Survey < ApplicationRecord
    has_one :problem_statement, dependent: :destroy
    has_one :solution_statement, dependent: :destroy
  end

  class ProblemStatement < ApplicationRecord
    belongs_to :survey, touch: true
  end

  class SolutionStatement < ApplicationRecord
    belongs_to :survey, touch: true
  end

  def problem_statement_default
    {
      headline: "Problems you experience",
      subheadline: "Please allocate 100 points across the problems and how severe they are to you. Allocate
                    more points to those problems which are more important to you. If a problem has no
                    importance it is okay to allocate zero (0) points to it.",
      open_ended_question: true
    }
  end

  def solution_statement_default
    {
      headline: "How do you perceive these solutions?",
      subheadline: "For each of the statements below, please rate how well the statement resonates with you.
                    1 means the statement does not resonate with you at all, 5 means the statement resonates
                    with you very well.",
      open_ended_question: true,
      min_scale: 1,
      max_scale: 5,
      lowest_value_label: "don’t identify",
      highest_value_label: "strongly identify"
    }
  end

  def change
    Survey.find_each do |survey|
      survey.create_problem_statement(problem_statement_default)
      survey.create_solution_statement(solution_statement_default)
    end
  end
end
