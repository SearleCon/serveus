require 'delayed_job'

module Delayed
  module AutoScaler
    module Scaler

      class Base
        def self.jobs
          Delayed::Job.where(failed_at: nil)
        end
      end

      module HerokuClient

        def client
          @client ||= Heroku::API.new
        end
      end

    end
  end
end
