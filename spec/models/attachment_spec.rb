# == Schema Information
#
# Table name: attachments
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  interaction_id     :integer
#  image_processing   :boolean
#

require 'spec_helper'

describe Attachment do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:attachment)).to be_valid
  end

  it { should belong_to(:interaction).touch(true) }
  it { should have_attached_file(:image) }
  it { should validate_attachment_size(:image).
                  less_than(1.megabytes) }

  describe 'Callbacks' do
    describe 'before_create' do
      it { described_class._create_callbacks.select { |cb| cb.kind.eql?(:before) }.collect(&:filter).should include(:set_name_to_file_name) }

      describe '#set_name_to_file_name' do
          it 'should set the attachment name to the filename' do
            attachment = build(:attachment)
            attachment.send(:set_name_to_file_name)
            expect(attachment.name).to eql(File.basename(attachment.image_file_name, ".*"))
          end
      end
    end
  end

end
