class User < ApplicationRecord
  has_secure_password
  has_many :projects, as: :projectable

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, presence: true, length: { minimum: 8 }

  has_many :api_keys, as: :bearer
  after_create :generate_api_key

  private

  def generate_api_key
    api_keys.create!
  end
end
