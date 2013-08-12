# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  provider               :string(255)
#  uid                    :string(255)
#  time_zone              :string(255)
#  invitation_token       :string(60)
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  name                   :string(255)
#

require 'spec_helper'

describe User do
 it 'has a valid factory' do
   expect(FactoryGirl.create(:user)).to be_valid
 end

 it {should have_many(:incidents)}
 it {should have_many(:tags)}
 it {should have_one(:basket)}

 describe 'Callbacks' do
   describe 'after_initialize' do
     it { described_class._initialize_callbacks.select { |cb| cb.kind.eql?(:after) }.collect(&:filter).should include(:init) }

     describe '#init' do
       it 'should set the current time zone' do
         user = build(:user)
         user.send(:init)
         expect(user.time_zone).to eq Time.zone.name
       end
     end
   end
 end

end
