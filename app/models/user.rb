class User < ActiveRecord::Base
  has_and_belongs_to_many :products

  # before_save :encrypt_password

  has_secure_password

  # validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email

  # def encrypt_password
  #   if password.present?
  #     self.password
  # end
end
