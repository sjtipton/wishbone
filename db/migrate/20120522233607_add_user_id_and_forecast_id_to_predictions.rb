class AddUserIdAndForecastIdToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :user_id, :integer, null: false
    add_column :predictions, :forecast_id, :integer, null: false
  end

  def down
    remove_column :predictions, :user_id
    remove_column :predictions, :forecast_id
  end
end
