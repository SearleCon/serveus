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
  it 'has a valid factory' do
    expect(create(:feedback)).to be_valid
  end

  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:comment) }
end
