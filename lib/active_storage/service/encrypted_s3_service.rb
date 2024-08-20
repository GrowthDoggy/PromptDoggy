require "active_storage/service/s3_service"

# Thanks to https://medium.com/tailor-tech/how-to-use-ruby-active-storage-s3-with-client-side-encryption-b12024d4f14

module ActiveStorage
  class Service::EncryptedS3Service < Service::S3Service
    attr_reader :encryption_client

    def initialize(bucket:, upload: {}, **options)
      super_options = options.except(:kms_key_id, :encryption_key, :key_wrap_schema, :content_encryption_schema, :security_profile)
      super(bucket: bucket, upload: upload, **super_options)
      @encryption_client = Aws::S3::EncryptionV2::Client.new(options)
    end

    def upload(key, io, checksum: nil, **)
      instrument :upload, key:, checksum: do
        @encryption_client.put_object(
          upload_options.merge(body: io, bucket: bucket.name, key:)
        )
      rescue Aws::S3::Errors::BadDigest
        raise ActiveStorage::IntegrityError
      end
    end

    def download(key, &block)
      instrument :download, key: do
        @encryption_client.get_object(bucket: bucket.name, key:).body.string.force_encoding(Encoding::BINARY)
      end
    end
  end
end