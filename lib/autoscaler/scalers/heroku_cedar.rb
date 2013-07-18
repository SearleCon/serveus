require 'heroku-api'

module Delayed
  module AutoScaler
    module Scaler
      class HerokuCedar < Base

        def self.client
            @client ||= ::Heroku::API.new
        end

        def self.scale
          if self.jobs.size > 0
            client.post_ps_scale(ENV['APP_NAME'], 'worker', 1) if self.workers < 1
          else
            client.post_ps_scale(ENV['APP_NAME'], 'worker', 0) unless self.workers == 0
          end
        end

        def self.up
          client.post_ps_scale(ENV['APP_NAME'], 'worker', 1) if self.workers < 1
        end

        def self.down
          client.post_ps_scale(ENV['APP_NAME'], 'worker', 0) unless (self.workers == 0 || self.jobs.size > 1)
        end

        def self.workers
          client.get_ps(ENV['APP_NAME']).body.count { |p| p["process"] =~ /worker\.\d?/ }
        end
      end
    end
  end
end