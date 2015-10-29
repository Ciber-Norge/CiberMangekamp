class AddFirstVersionOfDatabase < ActiveRecord::Migration
  def change
    create_table :seasons do | t |
      t.integer :year, limit: 2, null: false
      t.string  :title

      t.timestamps null: false
    end

    create_table :events do | t |
      t.belongs_to :season, index: true

      t.date   :date,  null: false
      t.string :title, null: false
      t.string :sport, null: false
      t.string :venue

      t.timestamps null: false
    end

    create_table :participants do | t |
      t.belongs_to :event, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end

    create_table :results do | t |
      t.belongs_to :participant, index: true
      t.belongs_to :event, index: true

      t.integer    :rank, null: false
      t.string     :score

      t.timestamps null: false
    end

    create_table :users do | t |
      t.string :title, null: false
      t.string :email

      t.timestamps null: false
    end
  end
end
