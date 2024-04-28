class AddScalesToProblemStatement < ActiveRecord::Migration[5.2]
  def change
    add_column :problem_statements, :min_scale, :integer, default: 0
    add_column :problem_statements, :max_scale, :integer, default: 1
    add_column :problem_statements, :lowest_value_label, :string
    add_column :problem_statements, :highest_value_label, :string
  end
end
