class AddFieldsToMarketSegments < ActiveRecord::Migration[5.2]
  def change
    add_column :market_segments, :min_scale, :integer, default: 0
    add_column :market_segments, :max_scale, :integer, default: 1
    add_column :market_segments, :lowest_value_label, :string
    add_column :market_segments, :highest_value_label, :string
    add_column :market_segments, :open_ended_question, :boolean, default: false
  end
end
