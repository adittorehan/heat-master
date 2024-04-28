require 'test_helper'

class MarketSegmentTest < ActiveSupport::TestCase
  should belong_to(:survey).touch(true)
  should validate_presence_of :segment_questions
  should validate_length_of(:segment_questions).is_at_most(5)
end
