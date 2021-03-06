require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Serveus
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.


    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pretoria'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de


    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.assets.precompile += %w(pdf.css)
    config.assets.precompile += %w(incidents.js interactions.js trash.js emails.js)


    config.exceptions_app = self.routes

    #config.autoload_paths << "#{Rails.root}/app/jobs"


    config.paperclip_defaults = {
        s3_credentials: {
            bucket: ENV["S3_BUCKET"],
            access_key_id: ENV["S3_ACCESS_KEY_ID"],
            secret_access_key: ENV["S3_SECRET_ACCESS_KEY"]
        },
        s3_permissions: :private,
        s3_host_name: ENV["S3_HOST_NAME"],
        s3_headers: {'Expires' => 1.year.from_now.httpdate,
                     'Content-Disposition' => 'inline'}
    }
  end
end
