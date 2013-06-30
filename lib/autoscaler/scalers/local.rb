require 'rush'

module Delayed
  module AutoScaler
    module Scaler

      class Local < Base
        def self.scale
          if self.jobs.size > 0
            Rush::Box.new[Rails.root].bash("bin/delayed_job start -i autoscaler", background: true) if self.workers == 0
            sleep 1
          else
            Rush::Box.new[Rails.root].bash("bin/delayed_job stop -i autoscaler", background: true) if self.workers > 0
          end
        end

        def self.workers
          Rush::Box.new.processes.filter(cmdline: /delayed_job start -i autoscaler|delayed_job.autoscaler/).size
        end
      end
    end
  end
end
