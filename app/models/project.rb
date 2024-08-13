class Project < ApplicationRecord
  belongs_to :projectable, polymorphic: true

  validates :name, presence: true

  has_secure_token :token

  def to_param
    token
  end
end
