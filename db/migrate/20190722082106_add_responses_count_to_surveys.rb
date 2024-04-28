class AddResponsesCountToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :responses_count, :integer, default: 0
  end
end
