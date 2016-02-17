class ChangeEventToRequireCategory < ActiveRecord::Migration
  def change
    change_column_null :events, :category_id, false
  end
end
