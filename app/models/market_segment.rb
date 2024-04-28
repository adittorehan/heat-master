class MarketSegment < ApplicationRecord
  before_save :reject_empty

  belongs_to :survey, touch: true

  validates :segment_questions, presence: true, length: { maximum: 5 }

  def reject_empty
    segment_questions.reject! { |_key, value| value == "" }
  end
end
