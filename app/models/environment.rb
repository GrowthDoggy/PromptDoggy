class Environment < ApplicationRecord
  belongs_to :project

  has_secure_token :token

  validates :name, presence: true

  def to_param
    token
  end
end
