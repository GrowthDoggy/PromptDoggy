class Prompt < ApplicationRecord
  belongs_to :project
  has_many :deployments, dependent: :destroy
  encrypts :content

  validates :name, presence: true

end
