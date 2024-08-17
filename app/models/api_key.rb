class ApiKey < ApplicationRecord
  belongs_to :bearer, polymorphic: true

  has_secure_token :token, length: 36

  # https://guides.rubyonrails.org/active_record_encryption.html#deterministic-and-non-deterministic-encryption
  # Effectively enabling querying encrypted data by enabling deterministic encryption
  encrypts :token, deterministic: true
end
