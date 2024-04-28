require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  should belong_to(:survey)
end
