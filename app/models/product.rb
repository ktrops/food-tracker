class Product < ActiveRecord::Base
  has_one :category
  has_many :user_products
  has_many :users, through: :user_products

end
