class Survey < ApplicationRecord
  belongs_to :project, touch: true
  has_one :introduction, dependent: :destroy
  has_one :market_segment, dependent: :destroy
  has_one :problem_statement, dependent: :destroy
  has_one :solution_statement, dependent: :destroy
  has_one :feedback, dependent: :destroy
  has_one :ending, dependent: :destroy
  has_many :results, dependent: :destroy
  accepts_nested_attributes_for :introduction
  accepts_nested_attributes_for :market_segment
  accepts_nested_attributes_for :problem_statement
  accepts_nested_attributes_for :solution_statement
  accepts_nested_attributes_for :feedback
  accepts_nested_attributes_for :ending

  validates :name, presence: true

  def segment_questions
    market_segment.segment_questions.values.sort
  end

  def problem_questions
    problem_statement.problem_segments.values.sort
  end

  def solution_questions
    solution_statement.solution_segments.values.sort
  end

  def feedback_questions
    feedback.ask_for_testing_options.split("\n").sort
  end
end
