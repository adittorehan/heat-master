require 'test_helper'

class SolutionStatementTest < ActiveSupport::TestCase
  should belong_to(:survey).touch(true)
  should validate_presence_of :solution_segments
  should validate_length_of(:solution_segments).is_at_most(5)
end
