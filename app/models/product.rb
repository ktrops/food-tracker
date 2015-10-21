class Product < ActiveRecord::Base
  has_one :category
  has_many :user_products
  has_many :users, through: :user_products

  def self.find_by_name_or_subname(string)
    lower = string.downcase
    name = Product.where("name LIKE ?", "%#{lower}%")
    subname = Product.where("subname LIKE ?", "%#{lower}%")
    product = name + subname
    if product.empty?
      capital = string.capitalize
      name = Product.where("name LIKE ?", "%#{capital}%")
      subname = Product.where("subname LIKE ?", "%#{capital}%")
      product = name + subname
    end

    product

  end



end
