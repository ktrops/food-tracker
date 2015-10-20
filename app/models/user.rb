require 'securerandom'

class User < ActiveRecord::Base
  has_many :user_products
  has_many :products, through: :user_products

  # before_save :encrypt_password
  # \w+@\w+\.\w+
  # 206-?\d{3}-?\d{4}

  has_secure_password

  # validates_confirmation_of :password
  # validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.email = auth["info"]["email"]
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.password = SecureRandom.uuid
      # user.password_confirmation = auth["uid"]
    end
  end

  # def encrypt_password
  #   if password.present?
  #     self.password
  # end
end
