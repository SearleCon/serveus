# == Schema Information
#
# Table name: incidents
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  open       :boolean
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Incident do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:incident)).to be_valid
  end


  it {should belong_to(:user)}

  it {should have_many(:interactions)}

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:user) }


end
