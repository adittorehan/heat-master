require 'test_helper'

class EndingTest < ActiveSupport::TestCase
  should belong_to(:survey).touch(true)
end
