# == Schema Information
#
# Table name: attachments
#
#  id                       :integer          not null, primary key
#  name                     :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  local_image_file_name    :string(255)
#  local_image_content_type :string(255)
#  local_image_file_size    :integer
#  local_image_updated_at   :datetime
#  image_file_name          :string(255)
#  image_content_type       :string(255)
#  image_file_size          :integer
#  image_updated_at         :datetime
#  interaction_id           :integer
#

require 'spec_helper'

describe Attachment do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:attachment)).to be_valid
  end

  it { should belong_to(:interaction).touch(true) }
  it { should have_attached_file(:local_image) }
  it { should have_attached_file(:image) }

  describe 'Callbacks' do
    describe 'before_create' do
      it { described_class._create_callbacks.select { |cb| cb.kind.eql?(:before) }.collect(&:filter).should include(:set_name_to_file_name) }

      describe '#set_name_to_file_name' do
          it 'should set the attachment name to the filename' do
            attachment = build(:attachment)
            attachment.send(:set_name_to_file_name)
            expect(attachment.name).to eql(File.basename(attachment.local_image_file_name, ".*"))
          end
      end
    end

    describe 'after_save' do
      it { described_class._save_callbacks.select { |cb| cb.kind.eql?(:after) }.collect(&:filter).should include(:queue_upload_to_s3) }

      describe '#queue_upload_to_s3' do
        it 'should queue an upload job in delayed job' do
          attachment = build(:attachment)
          attachment.send(:queue_upload_to_s3)
          expect(Delayed::Job.last.handler).to include(ImageJob.to_s)
        end
      end

    end
  end

end
