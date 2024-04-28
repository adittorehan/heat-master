require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  should belong_to(:project).touch(true)
  should have_one :introduction
  should have_one :market_segment
  should have_one :problem_statement
  should have_one :solution_statement
  should have_one :feedback
  should have_one :ending
  should have_many :results
  should accept_nested_attributes_for :introduction
  should accept_nested_attributes_for :market_segment
  should accept_nested_attributes_for :problem_statement
  should accept_nested_attributes_for :solution_statement
  should accept_nested_attributes_for :feedback
  should accept_nested_attributes_for :ending

  should validate_presence_of :name
end
