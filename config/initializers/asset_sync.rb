AssetSync.configure do |config|
=begin
  config.fog_provider = ENV['S3_PROVIDER']
  config.aws_access_key_id = ENV['S3_ACCESS_KEY_ID']
  config.aws_secret_access_key = ENV['S3_SECRET_ACCESS_KEY']
  config.fog_directory = ENV['S3_BUCKET']
=end

  config.fog_provider = 'AWS'
  config.aws_access_key_id = 'AKIAJTDIXL57Z4GG4IKA'
  config.aws_secret_access_key = '7d8apJW1q+kjoqIBYbqUCqi25ACXIMSvNDhsepjt'
  config.fog_directory = 'searlecon'


  # Increase upload performance by configuring your region
  config.fog_region = ENV['S3_REGION']

  # Automatically replace files with their equivalent gzip compressed version
  config.gzip_compression = true
  #
  # Use the Rails generated 'manifest.yml' file to produce the list of files to
  # upload instead of searching the assets directory.
  config.manifest = true
  #
  # Fail silently.  Useful for environments such as Heroku
  config.fail_silently = true
end
