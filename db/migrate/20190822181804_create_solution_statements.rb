class CreateSolutionStatements < ActiveRecord::Migration[5.2]
  def change
    create_table :solution_statements do |t|
      t.references :survey, foreign_key: true
      t.string :headline
      t.string :subheadline
      t.jsonb :solution_segments, default: {}
      t.integer :min_scale, default: 0
      t.integer :max_scale, default: 5
      t.string :lowest_value_label
      t.string :highest_value_label
      t.boolean :open_ended_question, default: true

      t.timestamps
    end
  end
end
