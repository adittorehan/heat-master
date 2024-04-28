module AnalyticsHelper # rubocop:disable Metrics/ModuleLength
  def market_to_problem_ratios(survey, market_segment)
    ratios = []
    results_amount = survey.results.count

    survey.problem_questions.each do |problem|
      ratio = 0
      survey.results.sort.each do |result|
        market_segment_value = result.market_segment_answers[market_segment].to_f
        problem_statement_value = result.problem_statement_answers[problem].to_f

        ratio += (market_segment_value + problem_statement_value) / 2
      end
      ratios << (ratio / results_amount).ceil(2)
    end
    ratios
  end

  def solution_to_problem_ratios(survey, solution_statement)
    ratios = []
    results_amount = survey.results.count

    survey.problem_questions.each do |problem|
      ratio = 0
      survey.results.sort.each do |result|
        solution_statement_value = result.solution_statement_answers[solution_statement].to_f
        problem_statement_value = result.problem_statement_answers[problem].to_f

        ratio += (solution_statement_value + problem_statement_value) / 2
      end
      ratios << (ratio / results_amount).ceil(2)
    end
    ratios
  end

  def number_to_answer(value)
    value == "1" ? "yes" : "no"
  end

  def largest_hash_by_value(hash)
    hash.max_by { |_k, v| v }
  end

  def lowest_hash_by_value(hash)
    hash.min_by { |_k, v| v }
  end

  def low_scored_segments_keys(sums, median_score)
    sums.select { |_key, value| value < median_score }.to_h.keys
  end

  def responses_count(survey)
    survey.results.length
  end

  def list_of_markets_with_total_score(survey)
    survey.segment_questions.map do |segment|
      sums = []
      survey.results.each do |result|
        sum = 0
        sum += result.market_segment_answers[segment].to_i
        sums << sum
      end
      [segment, sums.sum]
    end
  end

  def list_of_problems_with_total_score(survey)
    survey.problem_questions.map do |segment|
      sums = []
      survey.results.each do |result|
        sum = 0
        sum += result.problem_statement_answers[segment].to_i
        sums << sum
      end
      [segment, sums.sum]
    end
  end

  def list_of_solutions_with_total_score(survey)
    survey.solution_questions.map do |segment|
      sums = []
      survey.results.each do |result|
        sum = 0
        sum += result.solution_statement_answers[segment].to_i
        sums << sum
      end
      [segment, sums.sum]
    end
  end

  def top_market(survey)
    segments_list = list_of_markets_with_total_score(survey)
    largest_hash_by_value(segments_list.to_h).first
  end

  def top_problem(survey)
    segments_list = list_of_problems_with_total_score(survey)
    largest_hash_by_value(segments_list.to_h).first
  end

  def top_solution(survey)
    segments_list = list_of_solutions_with_total_score(survey)
    largest_hash_by_value(segments_list.to_h).first
  end

  def bottom_market(survey)
    segments_list = list_of_markets_with_total_score(survey)
    lowest_hash_by_value(segments_list.to_h).first
  end

  def bottom_solution(survey)
    segments_list = list_of_solutions_with_total_score(survey)
    lowest_hash_by_value(segments_list.to_h).first
  end

  def bottom_problem(survey)
    segments_list = list_of_problems_with_total_score(survey)
    lowest_hash_by_value(segments_list.to_h).first
  end

  def below_average_markets(survey)
    segments_list = list_of_markets_with_total_score(survey)
    responses_count = responses_count(survey)
    median = 3
    median_score = median * responses_count

    low_scored_segments_keys(segments_list, median_score)
  end

  def below_average_problems(survey)
    segments_list = list_of_problems_with_total_score(survey)
    responses_count = survey.results.length
    median = 50
    median_score = median * responses_count

    low_scored_segments_keys(segments_list, median_score)
  end

  def below_average_solutions(survey)
    segments_list = list_of_solutions_with_total_score(survey)
    responses_count = responses_count(survey)
    median = 3
    median_score = median * responses_count

    low_scored_segments_keys(segments_list, median_score)
  end
end
