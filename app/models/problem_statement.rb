class ProblemStatement < ApplicationRecord
  before_save :reject_empty

  belongs_to :survey, touch: true

  validates :problem_segments, presence: true, length: { maximum: 5 }

  def reject_empty
    problem_segments.reject! { |_key, value| value == "" }
  end
end
