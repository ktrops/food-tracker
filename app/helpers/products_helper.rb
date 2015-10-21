module ProductsHelper
  def expiration_date_min(product, storage)
    date = Time.now
    if product.dynamic_dop_min(storage, "metric") == "Months"
      expiration_date =  date + product.dynamic_dop_min(storage, "dop").month
    elsif product.dynamic_dop_min(storage, "metric") == "Years"
      expiration_date =  date + product.dynamic_dop_min(storage, "dop").year
    elsif product.dynamic_dop_min(storage, "metric") == "Days"
      expiration_date =  date + product.dynamic_dop_min(storage, "dop")
    else
      expiration_date = 0
    end
    expiration_date

  end

  def dynamic_dop_min(storage, type)
    if type == "dop"
      variable = storage + "_dop_min"
      send(variable.to_sym)
    elsif type == "metric"
      variable = storage + "_metric"
      send(variable.to_sym)
    end
  end
end
