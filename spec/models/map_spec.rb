# == Schema Information
#
# Table name: maps
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Map do
  let(:map) { create(:map) }

  it 'is valid with valid attributes' do
    expect(map).to be_valid
  end

  it 'has a unique name' do
    expect {
      create(:map, :name => 'Default')
      create(:map, :name => 'Default')
    }.to raise_error
  end

end
