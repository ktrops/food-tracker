require 'httparty'

products_uri = "http://localhost:3000/product/all"
categories_uri = "http://localhost:3000/category/all"

items = HTTParty.get(products_uri)
categories = HTTParty.get(categories_uri)

categories.each do |cat|
 Category.create(
  category: cat['category'],
  subcategory: cat['subcategory']
  )
end


items.each do |item|
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
       freezer_tips: item['freezer_tips']

    )
end
