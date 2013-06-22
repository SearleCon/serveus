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
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.exceptions_app = self.routes

    config.autoload_paths << "#{Rails.root}/app/jobs"


    config.generators do |g|
       g.test_framework :rspec,
       fixtures: true,
       view_specs: false,
       helper_specs: false,
       routing_specs: false,
       controller_specs: true,
       request_specs: false
       g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    config.paperclip_defaults = {
        s3_credentials: {
            bucket: 'searlecon',
            access_key_id: 'AKIAJTDIXL57Z4GG4IKA',
            secret_access_key: '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'
        },
        s3_permissions:  :public_read,
        s3_host_name:    's3-eu-west-1.amazonaws.com',
        s3_headers:      {'Expires' => 1.year.from_now.httpdate,
                          'Content-Disposition' => 'attachment'},
    }
  end
end
