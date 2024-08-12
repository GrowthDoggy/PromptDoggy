class User < ApplicationRecord
  has_secure_password
  has_many :projects, as: :projectable

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, presence: true, length: { minimum: 8 }
end
