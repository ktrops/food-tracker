class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token unless Rails.env.prodution?

    def expiration_date_min(product, storage)
    date = Time.now
    if dynamic_dop_min(product, storage, "metric") == "Months"
      expiration_date =  date + dynamic_dop_min(product, storage, "dop").month
    elsif dynamic_dop_min(product, storage, "metric") == "Years"
      expiration_date =  date + dynamic_dop_min(product, storage, "dop").year
    elsif dynamic_dop_min(product, storage, "metric") == "Days"
      expiration_date =  date + dynamic_dop_min(product, storage, "dop")
    else
      expiration_date = 0
    end
    expiration_date

  end

  def dynamic_dop_min(product, storage, type)
    if type == "dop"
      variable = storage + "_dop_min"
      product.send(variable.to_sym)
    elsif type == "metric"
      variable = storage + "_dop_metric"
      product.send(variable.to_sym)
    end
  end



  def categorize_product(product, user_product)
    if product.pantry == true
      user_product.location = "pantry"
      user_product.dop_expiration_date_min = expiration_date_min(product, "pantry")
      return user_product

    elsif product.fridge == true
      user_product.location = "fridge"
      user_product.dop_expiration_date_min = expiration_date_min(product, "fridge")
      return user_product
    else
      user_product.location = "freezer"
      user_product.dop_expiration_date_min = expiration_date_min(product, "freezer")
      return user_product
    end
  end


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
