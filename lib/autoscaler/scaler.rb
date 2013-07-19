require 'autoscaler/scalers/local'
require 'autoscaler/scalers/heroku_cedar'
require 'autoscaler/scalers/null'



module Delayed
  module AutoScaler
    module Scaler

      def self.included(base)
        base.send :extend, ClassMethods
        base.class_eval do
          after_commit "self.class.scaler.up", on: :create
          after_commit "self.class.scaler.down", on: :destroy
        end
      end

      module ClassMethods
        def scaler
          @scaler
        end

        def scaler=(scaler)
          @scaler = "Delayed::AutoScaler::Scaler::#{scaler.to_s.camelize}".constantize
        end
      end
    end
  end
end
