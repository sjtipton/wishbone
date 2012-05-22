class AddTeamsToUser < ActiveRecord::Migration
  def change
    add_column :users, :teams, :text
  end

  def down
    remove_column :users, :teams
  end
end
