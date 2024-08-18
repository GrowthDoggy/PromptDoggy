require "active_storage/service/s3_service"

module ActiveStorage
  class Service::EncryptedS3Service < Service::S3Service
    attr_reader :encryption_client

    def initialize(bucket:, upload: {}, **options)
      super_options = options.except(:kms_key_id, :encryption_key)
      super(bucket: bucket, upload: upload, **super_options)
      @encryption_client = Aws::S3::Encryption::Client.new(options)
    end

    def upload(key, io, checksum: nil, **)
      instrument :upload, key: key, checksum: checksum do
        begin
          encryption_client.put_object(
            upload_options.merge(
              body: io,
              content_md5: checksum,
              bucket: bucket.name,
              key: key
            )
          )
        rescue Aws::S3::Errors::BadDigest
          raise ActiveStorage::IntegrityError
        end
      end
    end

    def download(key, &block)
      if block_given?
        raise NotImplementedError, "#get_object with :range not supported yet"
      else
        instrument :download, key: key do
          encryption_client.get_object(
            bucket: bucket.name,
            key: key
          ).body.string.force_encoding(Encoding::BINARY)
        end
      end
    end

    def download_chunk(key, range)
      raise NotImplementedError, "#get_object with :range not supported yet"
    end
  end
end