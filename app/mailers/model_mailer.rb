class ModelMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.expiration_notification.subject
  #
  def expiration_notification(product, user)
    @product = product
    @greeting = "Hi"

    # user = User.find(session[:user_id])

    mail to: user.email, subject: "Your food is going to expire."
  end
end
