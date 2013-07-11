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

  describe 'Callbacks' do
    describe 'after_commit' do
      it { described_class._commit_callbacks.select { |cb| cb.kind.eql?(:after) }.collect(&:filter).should include(:notify_support) }

      describe '#notify_support' do
        it 'should send an email to support' do
          feedback = build(:feedback)
          feedback.send(:notify_support)
          expect(Delayed::Job.last.handler).to include(FeedbackMailJob.to_s)
        end
      end
    end
  end
end
