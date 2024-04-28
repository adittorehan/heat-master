class CreateMarketSegments < ActiveRecord::Migration[5.2]
  def change
    create_table :market_segments do |t|
      t.references :survey, foreign_key: true
      t.string :headline
      t.string :subheadline
      t.jsonb :segment_questions, default: {}

      t.timestamps
    end
  end
end
