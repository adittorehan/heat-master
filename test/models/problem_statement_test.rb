require 'test_helper'

class ProblemStatementTest < ActiveSupport::TestCase
  should belong_to(:survey).touch(true)
  should validate_presence_of :problem_segments
  should validate_length_of(:problem_segments).is_at_most(5)
end
