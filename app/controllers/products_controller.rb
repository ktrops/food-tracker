class ProductsController < ApplicationController
  autocomplete :product, :name, :full => true

  def list
    @user = User.find(session[:user_id])
    @product = Product.new
    @user_product = @user.products
    user = User.find(session[:user_id])
    @user_products = user.products
  end

  def product_check
    name = params[:products][0][:name]
    @product = Product.find_by_name_or_subname(name)
    render :product_form


  end

  def change_location
    user_product = UserProduct.find(params[:user_product][:id])
    user_product.update(user_product_params)
    render :text => "Location Changed"
  end

  def product_form
    name = params[:product]
    @product = Product.find_by_name_or_subname(name)
  end

  def check_expiration_date

    Resque.enqueue(CheckExpiration)
  end

  def product_select
    @user_products = params[:products]
    binding.pry
    render :index
  end

  def create
    user = User.find(session[:user_id])
    not_saved_products = []
    params[:products].each do |product|
      @product = Product.find_by_name_or_subname(product[:name])
      # if @product1.length > 1 put a popup here so users can choose if the search returns multipule products.
      if @product
        @product.each do |product_for_user|
          user.products << product_for_user
          # raise
          instance_with_updated_date = categorize_product(product_for_user, user.user_products.last)
          instance_with_updated_date.save
          ModelMailer.expiration_notification(@product, user).deliver_now
        end
      else
        @product = Product.new(product_params)
        if @product.save
          user.products << @product
          categorize_product(@product, UserProduct.last)
          @product.save
        else
          not_saved_products.push(@product)
        end
      end
    end
    if not_saved_products.empty?
      redirect_to user_food_path
    else
      render :list
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
      @user_product = user_product
      if user_product.location == "pantry"
        @pantry.push([product, user_product])
      elsif user_product.location == "fridge"
        @fridge.push([product, user_product])
      elsif user_product.location == "freezer"
        @freezer.push([product, user_product])
      end
    end

  end

  def update_date
    user_product = UserProduct.find(params[:user_product][:id])
    # user_product.update(user_product_params)
    params[:user_product][:dop_expiration_date_min] = Time.zone.parse(params[:user_product][:dop_expiration_date_min])
    if user_product.update(user_product_params)
      print("THESE ARE THE PARAMS", user_product_params)
      render :text => "updated"
    else
      render :text => "not updated"
    end

  end

  def update
    @product = Product.find(params[:product][:id])
    @product.update(product_params)
    render :index
  end

  def user_product_params
    params.require(:user_product).permit(:dop_expiration_date_min, :dop_expiration_date_max, :location)
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
