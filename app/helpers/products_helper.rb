module ProductsHelper
  def expiration_date_format(date)
    if date.nil? || date == 0
      expiration_date = 2.days.from_now.strftime("%Y-%m-%d")
    else
      expiration_date = date.strftime("%Y-%m-%d")
    end
    expiration_date
  end

end
