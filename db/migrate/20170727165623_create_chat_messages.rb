class CreateChatMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_messages do |t|
      t.references :player, null: false
      t.integer :tick, null: false
      t.string :message

      t.timestamps
    end
  end
end
