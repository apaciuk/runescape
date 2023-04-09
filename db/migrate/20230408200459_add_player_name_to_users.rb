class AddPlayerNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :player_name, :string
  end
end
