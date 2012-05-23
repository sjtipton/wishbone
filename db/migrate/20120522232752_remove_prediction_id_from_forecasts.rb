class RemovePredictionIdFromForecasts < ActiveRecord::Migration
  def up
    remove_column :forecasts, :prediction_id
  end

  def down
    add_column :forecasts, :prediction_id, :integer, null: false
  end
end
