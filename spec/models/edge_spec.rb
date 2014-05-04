# == Schema Information
#
# Table name: edges
#
#  id         :integer          not null, primary key
#  source     :integer
#  target     :integer
#  cost       :float
#  map_id     :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_edges_on_map_id  (map_id)
#

require 'spec_helper'

describe Edge do
  let(:map)  { create(:map) }
  let(:source_node) { create(:node, :map_id => map.id, :name => 'A') }
  let(:target_node) { create(:node, :map_id => map.id, :name => 'B') }

  let(:edge) {
    create(:edge, :map_id => map.id, :source => source_node.id, :target => target_node.id, :cost => 10)
  }

  it 'is valid with valid attributes' do
    expect(edge).to be_valid
  end
end
