require 'heroku-api'

module Delayed
  module AutoScaler
    module Scaler
      class Heroku < Base

        def self.client
            @client ||= Heroku::API.new
        end

        def self.up
          client.post_ps_scale(ENV['APP_NAME'], 'worker', self.max_workers) if self.workers < self.max_workers
        end

        def self.down
          client.post_ps_scale(ENV['APP_NAME'], 'worker', self.min_workers) unless self.jobs.count > 0 || self.workers == self.min_workers
        end

        def self.workers
          client.get_ps(ENV['APP_NAME']).body.count { |p| p["process"] =~ /worker\.\d?/ }
        end


        def self.max_workers
          1
        end

        def self.min_workers
          0
        end
      end
    end
  end
end