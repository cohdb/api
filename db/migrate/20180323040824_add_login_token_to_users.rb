class AddLoginTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :login_token, :string
    add_column :users, :login_token_sent_at, :datetime
  end
end
