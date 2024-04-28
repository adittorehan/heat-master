require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  should belong_to(:survey).touch(true)
end
