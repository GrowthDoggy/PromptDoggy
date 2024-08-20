class Prompt < ApplicationRecord
  has_paper_trail

  belongs_to :project
  has_many :deployments, dependent: :destroy
  encrypts :content

  # Add a validation to ensure that the name is present and unique within the scope of the project_token.
  # TODO: Add an unique index to the name and project_id columns?
  validates :name, presence: true, uniqueness: { scope: :project_id }

  has_one_attached :deployed_file, service: :amazon_encrypted

  # https://stackoverflow.com/a/5263322/3970355
  scope :last_static_deployment, -> (is_static) {
    joins(:deployments)
      .where('deployments.created_at = (SELECT MAX(deployments.created_at) FROM deployments WHERE deployments.prompt_id = prompts.id)')
      .where('deployments.is_static = ?', is_static)
      .group('prompts.id')
  }

  def as_json(options = {})
    super(options.merge(only: %i[id name content created_at updated_at]))
  end
end
