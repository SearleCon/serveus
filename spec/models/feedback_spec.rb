# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  comment    :text
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Feedback do
  pending "add some examples to (or delete) #{__FILE__}"
end
