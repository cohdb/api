# frozen_string_literal: true
class CreateReplays < ActiveRecord::Migration[5.0]
  def change
    create_table :replays do |t|
      t.references :user
      t.integer :version, null: false
      t.integer :length, null: false
      t.string :map, null: false
      t.integer :rng_seed, limit: 8
      t.string :opponent_type
      t.string :game_type
      t.datetime :recorded_at
      t.attachment :rec

      t.timestamps
    end
  end
end
