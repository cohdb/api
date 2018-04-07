# frozen_string_literal: true
class CreateCommands < ActiveRecord::Migration[5.0]
  def change
    create_table :commands do |t|
      t.references :player, null: false
      t.integer :internal_player_id, null: false
      t.integer :tick, null: false
      t.string :command_type, null: false
      t.integer :entity_id, null: false
      t.decimal :x
      t.decimal :y
      t.decimal :z

      t.timestamps
    end
  end
end
