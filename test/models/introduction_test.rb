require 'test_helper'

class IntroductionTest < ActiveSupport::TestCase
  should belong_to(:survey).touch(true)
  should validate_presence_of :headline
  should validate_presence_of :subheadline
end
