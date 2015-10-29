
# require ''

class CheckExpirationDate
  @queue = :date_queue
  def self.perform
    UserProduct.all.each do |product|
      unless product.dop_expiration_date_min.nil?
        if product.dop_expiration_date_min >= Date.tomorrow && product.user.id == 1

          ModelMailer.expiration_notification(product.name, product.user).deliver
        end
      end
    end

  end
end


