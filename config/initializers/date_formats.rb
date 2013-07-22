Time::DATE_FORMATS[:default] = Proc.new { |time| time.stamp("5 January 2000 23:59pm") }
Time::DATE_FORMATS[:form] = Proc.new { |time| time.stamp("01/07/2013 10:34:17 AM") }


