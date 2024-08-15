class Prompt < ApplicationRecord
  has_paper_trail

  belongs_to :project
  has_many :deployments, dependent: :destroy
  encrypts :content

  # Add a validation to ensure that the name is present and unique within the scope of the project_token.
  # TODO: Add an unique index to the name and project_id columns?
  validates :name, presence: true, uniqueness: { scope: :project_id }

end
