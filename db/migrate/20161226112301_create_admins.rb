class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string   "name",                            null: false
      t.string   "email"
      t.string   "password_digest"

      t.timestamps null: false
    end

    remove_column :users, :password_digest
  end
end
