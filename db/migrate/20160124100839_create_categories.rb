class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title

      t.timestamps null: false
    end

    remove_column :events, :category
    add_reference :events, :category, index: true, foreign_key: true
  end
end
