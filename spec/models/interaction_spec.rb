# == Schema Information
#
# Table name: interactions
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  content        :text
#  start_at       :datetime
#  contact_person :string(255)
#  contact_detail :string(255)
#  target_date    :datetime
#  incident_id    :integer
#  created_at     :datetime
#  updated_at     :datetime
#  basket_id      :integer
#

require 'spec_helper'

describe Interaction do
  it 'has a valid factory' do
    expect(create(:interaction)).to be_valid
  end

  it { should belong_to(:incident).touch(true) }
  it { should have_many(:attachments) }


  it { should validate_presence_of(:content) }


end
