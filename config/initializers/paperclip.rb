Paperclip.options[:content_type_mappings] = { rec: 'application/octet-stream' }

unless Rails.env.test?
  Paperclip::Attachment.default_options[:storage] = :s3
  Paperclip::Attachment.default_options[:s3_credentials] = {
    access_key_id: 'key',
    secret_access_key: 'key',
    bucket: 'bucket',
  }
  Paperclip::Attachment.default_options[:s3_region] = 'us-east-1'
  Paperclip::Attachment.default_options[:s3_protocol] = :https
  Paperclip::Attachment.default_options[:s3_permissions] = :private
  Paperclip::Attachment.default_options[:preserve_files] = 'true'
end
