class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.string :title, null: false
      t.integer :user_id, null: false
      t.integer :prediction_id, null: false

      t.timestamps
    end
  end
end
