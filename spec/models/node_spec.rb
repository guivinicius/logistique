# == Schema Information
#
# Table name: nodes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  map_id     :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_nodes_on_map_id           (map_id)
#  index_nodes_on_map_id_and_name  (map_id,name) UNIQUE
#

require 'spec_helper'

describe Node do
  let(:map)  { create(:map) }
  let(:map2)  { create(:map, :name => "Another") }

  let(:node) { create(:node, :map_id => map.id) }

  it 'is valid with valid attributes' do
    expect(node).to be_valid
  end

  it 'has a unique name within a map' do
    expect {
      create(:node, :name => 'A', :map_id => map.id)
      create(:node, :name => 'A', :map_id => map.id)
    }.to raise_error
  end

  it 'allows same name in different maps' do
    expect {
      create(:node, :name => 'A', :map_id => map.id)
      create(:node, :name => 'A', :map_id => map2.id)
    }.not_to raise_error
  end
end
