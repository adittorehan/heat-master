class SolutionStatement < ApplicationRecord
  before_save :reject_empty

  belongs_to :survey, touch: true

  validates :solution_segments, presence: true, length: { maximum: 5 }

  def reject_empty
    solution_segments.reject! { |_key, value| value == "" }
  end
end
