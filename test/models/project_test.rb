require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should belong_to(:workspace).touch(true)
  should have_one :survey

  should validate_presence_of :name
end
