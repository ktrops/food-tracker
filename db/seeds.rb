require 'httparty'

if Rails.env.production? == true
  products_uri = "http://foodtrackerapi.herokuapp.com/product/all"
  categories_uri = "http://foodtrackerapi.herokuapp.com/category/all"
  fridge_uri = "http://foodtrackerapi.herokuapp.com/fridge"
  freezer_uri = "http://foodtrackerapi.herokuapp.com/freezer"
  pantry_uri = "http://foodtrackerapi.herokuapp.com/pantry"
else
  products_uri = "http://localhost:3000/product/all"
  categories_uri = "http://localhost:3000/category/all"
  fridge_uri = "http://localhost:3000/fridge"
  freezer_uri = "http://localhost:3000/freezer"
  pantry_uri = "http://localhost:3000/pantry"
end



items = HTTParty.get(products_uri)
categories = HTTParty.get(categories_uri)
fridge = HTTParty.get(fridge_uri)
freezer = HTTParty.get(freezer_uri)
pantry = HTTParty.get(pantry_uri)

categories.each do |cat|
 Category.create(
  category: cat['category'],
  subcategory: cat['subcategory']
  )
end



items.each do |item|
  pantry_store = pantry.include?(item) ? true : false
  fridge_store = fridge.include?(item) ? true : false
  freezer_store = freezer.include?(item) ? true : false
  Product.create(
       category_id: item['category_id'],
       category_name: item['category'],
       name: item['name'],
       subname: item['subname'],
       pantry_dop_min: item['pantry_dop_min'],
       pantry_dop_max: item['pantry_dop_max'],
       pantry_dop_metric: item['pantry_dop_metric'],
       pantry_tips: item['pantry_tips'],
       fridge_dop_min: item['fridge_dop_min'],
       fridge_dop_max: item['fridge_dop_max'],
       fridge_dop_metric: item['fridge_dop_metric'],
       fridge_open_min: item['fridge_open_min'],
       fridge_open_max: item['fridge_open_max'],
       fridge_open_metric: item['fridge_open_metric'],
       fridge_after_thawing_min: item['fridge_after_thawing_min'],
       fridge_after_thawing_max: item['fridge_after_thawing_max'],
       fridge_after_thawing_metric: item['fridge_after_thawing_metric'],
       fridge_tips: item['fridge_tips'],
       freezer_dop_min: item['freezer_dop_min'],
       freezer_dop_max: item['freezer_dop_max'],
       freezer_dop_metric: item['freezer_dop_metric'],
       freezer_tips: item['freezer_tips'],
       fridge: fridge_store,
       freezer: freezer_store,
       pantry: pantry_store

    )
end

CSV.foreach('db/users.csv', headers: true) do |row|
  User.create(
    name: row["name"],
    phone: row["phone"],
    email: row["email"],
    password: row["password"],
    password_confirmation: row["password_digest"]
    )
end

CSV.foreach('db/user_products.csv', headers: true) do |row|
  user = User.find(row["user_id"])
  user.products << Product.find(row["product_id"])
  user_products = user.user_products
  # print(user_products)
  user_products.each do |user_product|
    product = Product.find(user_product.product_id)
    print("im the product " + product.id.to_s)
    if product.pantry == true
      user_product.location = "pantry"
    elsif product.fridge == true
      user_product.location = "fridge"
    else
      user_product.location = "freezer"
    end
    print("I'm the user product location " + user_product.location)
    # UserProduct.save
  end
  # user.products.location =
end

