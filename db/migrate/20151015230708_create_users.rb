class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :password_digest
      t.string :provider
      t.string :uid

      t.timestamps null: false
    end
  end
end
