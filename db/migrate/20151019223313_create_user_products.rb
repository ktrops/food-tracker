class CreateUserProducts < ActiveRecord::Migration
  def change
    create_table :user_products do |t|
      t.belongs_to :user, index: true
      t.belongs_to :product, index: true
      t.string :location
      t.datetime :dop_expiration_date_min
      t.datetime :dop_expiration_date_max
      t.datetime :thawed_expiration_date_min
      t.datetime :thawed_expiration_date_max

      t.timestamps null: false
    end
  end
end
