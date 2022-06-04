class AddOmniauthPfpToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :omniauth_pfp, :string
  end
end
