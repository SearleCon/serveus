require "#{Rails.application.root}/lib/email_processor"


Griddler.configure do |config|
  config.processor_class = EmailProcessor # MyEmailProcessor
  config.to = :hash
  config.reply_delimiter = '-- REPLY ABOVE THIS LINE --'
  config.email_service = :postmark
end