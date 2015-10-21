class ProductsController < ApplicationController
  def list
    @product = Product.new
  end

  def create
    user = User.find(session[:user_id])
    raise
    @product1 = Product.find_by_name_or_subname(params[:product][:name])
    # if @product1.length > 1 put a popup here so users can choose if the search returns multipule products.
    raise
    if @product1
      user.products << @product1
      @product1
      redirect_to user_food_path
    else
      @product2 = Product.new(product_params)
      if @product2.save
        user.products << @product2
        redirect_to user_food_path
      else
        render :list
      end
    end
  end

  def index
    user = User.find(session[:user_id])
    user_products = user.user_products
    date = DateTime.now
    @pantry = []
    @freezer = []
    @fridge = []
    user_products.each do |user_product|
      product = Product.find(user_product.product_id)
      # print("im the product " + product.id.to_s)
      if product.pantry == true
        user_product.location = "pantry"
        user_product.dop_expiration_date_min = expiration_date_min(product, "pantry")
        @pantry.push([user_product.product, user_product])

      elsif product.fridge == true
        user_product.location = "fridge"
        @fridge.push(user_product.product)
      else
        user_product.location = "freezer"
        @freezer.push(user_product.product)
      end
      # print("I'm the user product location " + user_product.location)
    end

  end

  def date(product)
    if product.pantry
    end
  end

  def product_params
    params.require(:product).permit(:category_id, :category_name, :name,
                                    :subname, :pantry_dop_min, :pantry_dop_max,
                                    :pantry_dop_metric, :pantry_tips, :fridge_dop_min,
                                    :fridge_dop_max, :fridge_dop_metric, :fridge_open_min,
                                    :fridge_open_max, :fridge_open_metric, :fridge_after_thawing_min,
                                    :fridge_after_thawing_max, :fridge_after_thawing_metric, :fridge_tips,
                                    :freezer_dop_min, :freezer_dop_max, :freezer_dop_metric, :freezer_tips)
  end
end
