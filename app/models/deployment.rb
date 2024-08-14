class Deployment < ApplicationRecord
  belongs_to :prompt
  belongs_to :environment

  validates :prompt_id, :environment_id, presence: true
  validates :is_static, inclusion: { in: [true, false] }
end
