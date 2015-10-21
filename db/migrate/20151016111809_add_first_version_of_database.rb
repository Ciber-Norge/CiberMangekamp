class AddFirstVersionOfDatabase < ActiveRecord::Migration
  def change
    create_table :seasons do | t |
    end

    create_table :events do | t |
    end

    create_table :participants do | t |
    end

    create_table :results do | t |
    end

    create_table :users do | t |
    end
  end
end
