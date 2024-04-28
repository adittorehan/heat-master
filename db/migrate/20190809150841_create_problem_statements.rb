class CreateProblemStatements < ActiveRecord::Migration[5.2]
  def change
    create_table :problem_statements do |t|
      t.references :survey, foreign_key: true
      t.string :headline
      t.string :subheadline
      t.jsonb :problem_segments, default: {}
      t.boolean :open_ended_question, default: true

      t.timestamps
    end
  end
end
