class SurveysChannel < ApplicationCable::Channel
  def subscribed
    stream_from "surveys"
  end

  def receive(data)
    survey = Survey.find(data["id"])
    survey.introduction.update!(data["introduction"])
    survey.market_segment.update!(data["market_segment"])
    survey.problem_statement.update!(data["problem_statement"])
    survey.solution_statement.update!(data["solution_statement"])
    survey.feedback.update!(data["feedback"])
    survey.ending.update!(data["ending"])
  end
end
