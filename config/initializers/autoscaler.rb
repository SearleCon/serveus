#require "#{Rails.application.root}/lib/autoscaler/scalers/base"
#require "#{Rails.application.root}/lib/autoscaler/scaler"
#
#
#Delayed::Worker.max_attempts = 3
Delayed::Worker.raise_signal_exceptions = :term
#Delayed::Backend::ActiveRecord::Job.send(:include, Delayed::AutoScaler::Scaler) if defined?(Delayed::Backend::ActiveRecord::Job)