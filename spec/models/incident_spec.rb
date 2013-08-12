# == Schema Information
#
# Table name: incidents
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  open               :boolean
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  interactions_count :integer          default(0)
#  trashed            :boolean          default(FALSE)
#

require 'spec_helper'

describe Incident do

  it 'has a valid factory' do
    expect(create(:incident)).to be_valid
  end

  it {should belong_to(:user)}

  it {should have_many(:interactions).dependent(:destroy)}

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:user) }

  describe 'Instance methods' do
    let(:incident) { create(:incident, name: 'test') }

    describe 'to_s' do
      it 'should return the name titleized' do
        expect(incident.to_s).to eq 'Test'
      end
    end

    describe 'to_param' do
      it 'should return the name and id concatenated' do
        expect(incident.to_param).to eq [incident.id, incident.name.parameterize].join("-")
      end
    end

    describe 'tag_cloud' do
      let(:tagged_incident) { create(:incident, :with_tagged_interaction ,tagged_with: 'test' ) }

      it 'should return an array of unique tag names' do

        expect(tagged_incident.tag_cloud).to eq ['test']
      end
    end
  end

  describe 'Callbacks' do
    describe 'after_initialize' do
      it { described_class._initialize_callbacks.select { |cb| cb.kind.eql?(:after) }.collect(&:filter).should include(:init) }

      describe '#init' do
        it 'should set the incident to be open' do
          incident = build(:incident)
          incident.send(:init)
          expect(incident.open).to be_true
        end
      end
    end
  end



end
