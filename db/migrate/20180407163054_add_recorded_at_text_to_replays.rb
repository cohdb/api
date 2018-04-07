# frozen_string_literal: true
class AddRecordedAtTextToReplays < ActiveRecord::Migration[5.0]
  def change
    add_column :replays, :recorded_at_text, :string, null: false, default: ''
  end
end
