require 'rush'

module Delayed
  module AutoScaler
    module Scaler

      class Local < Base
        def self.up
          Rush::Box.new[Rails.root].bash("bin/delayed_job start -i autoscaler", background: true) if self.workers == 0
          sleep 5
        end

        def self.down
          Rush::Box.new[Rails.root].bash("bin/delayed_job stop -i autoscaler", background: true) unless self.workers == 0 || self.jobs.size > 1
        end

        def self.workers
          Rush::Box.new.processes.filter(cmdline: /delayed_job start -i autoscaler|delayed_job.autoscaler/).size
        end
      end
    end
  end
end