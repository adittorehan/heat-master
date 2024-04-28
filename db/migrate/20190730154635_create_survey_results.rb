class CreateSurveyResults < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_results do |t|
      t.references :survey, foreign_key: true

      t.jsonb :market_segment_answers, default: {}
      t.string :market_segment_open_answer, limit: 256
      t.datetime :survey_completed_at
      t.string :user_token, limit: 128

      t.timestamps
    end
  end
end
