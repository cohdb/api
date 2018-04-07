# frozen_string_literal: true
class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.references :replay, null: false
      t.integer :internal_id, null: false
      t.string :name, null: false
      t.string :steam_id, null: false
      t.string :faction, null: false
      t.integer :team
      t.string :commander
      t.decimal :cpm

      t.timestamps
    end
  end
end
