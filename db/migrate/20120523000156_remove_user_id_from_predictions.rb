class RemoveUserIdFromPredictions < ActiveRecord::Migration
  def up
    remove_column :predictions, :user_id
  end

  def down
    add_column :predictions, :user_id, :integer, null: false
  end
end
