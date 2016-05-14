class AddEnableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :retired, :boolean, default: false, null: false
  end
end
