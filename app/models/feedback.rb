class Feedback < ApplicationRecord
  belongs_to :survey, touch: true

  def active?
    ask_for_testing? || ask_for_email? || open_ended_question?
  end
end
