class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :provider, null: false, default: "facebook"
      t.string :email, null: false, default: ""
      t.integer :sign_in_count, default: 0
      t.datetime :last_sign_in_at

      t.timestamps
    end
  end
end
