# Allowlist searchable attributes for ActiveStorage::Attachment
Rails.application.config.to_prepare do
  ActiveStorage::Attachment.class_eval do
    def self.ransackable_attributes(auth_object = nil)
      ["id", "name", "record_type", "record_id", "blob_id", "created_at"]
    end

    def self.ransackable_associations(auth_object = nil)
      ["blob"]
    end
  end
end
