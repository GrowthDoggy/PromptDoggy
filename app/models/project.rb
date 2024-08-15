class Project < ApplicationRecord
  belongs_to :projectable, polymorphic: true
  has_many :environments
  has_many :prompts

  validates :name, presence: true

  has_secure_token :token

  def to_param
    token
  end
end
