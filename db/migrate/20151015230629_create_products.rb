class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :category, index: true, foreign_key: true
      t.string :category_name
      t.string :name
      t.string :subname
      t.integer :pantry_dop_min
      t.integer :pantry_dop_max
      t.string :pantry_dop_metric
      t.string :pantry_tips
      t.integer :fridge_dop_min
      t.integer :fridge_dop_max
      t.string :fridge_dop_metric
      t.integer :fridge_open_min
      t.integer :fridge_open_max
      t.string :fridge_open_metric
      t.integer :fridge_after_thawing_min
      t.integer :fridge_after_thawing_max
      t.string :fridge_after_thawing_metric
      t.string :fridge_tips
      t.integer :freezer_dop_min
      t.integer :freezer_dop_max
      t.string :freezer_dop_metric
      t.string :freezer_tips
      t.boolean :user_data, default: false
      t.boolean :fridge, default: false
      t.boolean :pantry, default: false
      t.boolean :freezer, default: false

      t.timestamps null: false
    end
  end
end
