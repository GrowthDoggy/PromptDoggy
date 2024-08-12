class Project < ApplicationRecord
  belongs_to :projectable, polymorphic: true
  before_create :generate_token

  validates :name, presence: true
  validates :token, presence: true, uniqueness: true

  private

  def generate_token
    self.token = loop do
      token = SecureRandom.alphanumeric(8)
      break token unless Project.exists?(token: token)
    end
  end
end
