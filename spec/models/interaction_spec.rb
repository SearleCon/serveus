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
  it { should have_many(:attachments).dependent(:destroy) }

  it { should validate_presence_of(:content) }


  describe 'Instance methods' do
    describe 'contact_info' do
      let(:interaction) { build(:interaction, contact_person: 'Peter', contact_detail: 'peter@example.com')  }
      context 'with contact_person' do
        it 'should return the contact_person and contact_detail' do
           expect(interaction.contact_info).to eq 'Contacted Peter via peter@example.com'
        end
      end

      context 'without contact_person' do
        it 'should return the contact_detail' do
          interaction.contact_person = nil
          expect(interaction.contact_info).to eq 'Contacted peter@example.com'
        end
      end

    end
  end

  describe 'Callbacks' do
    describe 'before_validation' do
      it { described_class._validation_callbacks.select { |cb| cb.kind.eql?(:before) }.collect(&:filter).should include(:init_defaults) }

      describe '#init_defaults' do
        it 'should set the occurred and title to if there are none' do
          interaction = build(:interaction, occurred: nil, title: nil)
          interaction.send(:init_defaults)
          expect(interaction.occurred).to_not be_nil
          expect(interaction.title).to_not be_nil

        end
      end
    end
  end


end
