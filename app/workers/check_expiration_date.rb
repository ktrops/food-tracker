class CheckExpirationDate
  @queue = :date_queue

  def self.perform
    UserProduct.all.each do |user_product|
      unless user_product.dop_expiration_date_min.nil?
        if user_product.dop_expiration_date_min <= Date.tomorrow
          if user_product.user.id == 1 || user_product.user.id == 4

            ModelMailer.expiration_notification(user_product.product.name, user_product.user).deliver
          end
        end
      end
    end
  sleep 15
  end
end


