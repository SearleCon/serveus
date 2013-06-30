require 'delayed_job'

module Delayed
  module AutoScaler
    module Scaler

      class Base
        def self.jobs
          Delayed::Job.where(failed_at: nil)
        end
      end
    end
  end
end
