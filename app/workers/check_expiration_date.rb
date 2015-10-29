class CheckExpirationDate
  @queue = :date_queue
  def self.perform
    UserProducts.each do |product|
      if product.dop_expiration_date_min >= Date.tomorrow
        ModelMailer.expiration_notification(product.name, product.user).deliver
      end
    end

  end
end
