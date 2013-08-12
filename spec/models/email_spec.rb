require 'spec_helper'

describe Email do

  it 'has a valid factory' do
    expect(build(:email)).to be_valid
  end

  it { should validate_presence_of(:from) }
  it { should validate_presence_of(:to) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:body) }

end