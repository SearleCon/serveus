require 'rush'

module Delayed
  module AutoScaler
    module Scaler

      class Local < Base
        def self.up
          if self.workers == 0
            Rush::Box.new[Rails.root].bash("bin/delayed_job start -i autoscaler", background: true)
            sleep 1
          end
          true
        end

        def self.down
          unless jobs.count > 0 && workers > 0
            Rush::Box.new[Rails.root].bash("bin/delayed_job stop -i autoscaler", background: true)
          end
          true
        end

        def self.workers
          Rush::Box.new.processes.filter(cmdline: /delayed_job start -i autoscaler|delayed_job.autoscaler/).size
        end
      end
    end
  end
end
