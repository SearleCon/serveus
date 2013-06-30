require 'autoscaler/scalers/local'
require 'autoscaler/scalers/heroku_cedar'
require 'autoscaler/scalers/null'



module Delayed
  module AutoScaler
    module Scaler

      def self.included(base)
        base.send :extend, ClassMethods
        base.class_eval do
          after_commit "self.class.scaler.scale"
        end
      end

      module ClassMethods
        def scaler
          @scaler ||= if ENV.include?("HEROKU_API_KEY")
                        Scaler::HerokuCedar
                      else
                        Scaler::Local
                      end
        end

        def scaler=(scaler)
          @scaler = "Delayed::AutoScaler::Scaler::#{scaler.to_s.camelize}".constantize
        end
      end
    end
  end
end
