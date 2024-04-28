class RemoveResponsesCountFromSurveys < ActiveRecord::Migration[5.2]
  def change
    remove_column :surveys, :responses_count, :integer
  end
end
