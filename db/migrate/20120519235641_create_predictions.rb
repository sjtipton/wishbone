class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.integer :game_id, null: false
      t.integer :winning_team_id, null: false
      t.integer :losing_team_id, null: false
      t.integer :winning_team_score
      t.integer :losing_team_score

      t.timestamps
    end
  end
end
