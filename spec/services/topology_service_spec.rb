require 'spec_helper'

describe TopologyService do

  let(:map) { create(:map) }

  let(:network) do
    <<-eos
      A B 10
      B D 15
      A C 20
      C D 30
      B E 50
      D E 30
    eos
  end

  describe "#create!" do

    context 'when attributes are valid' do

      it 'creates new nodes' do
        expect {
          TopologyService.new(map, network).create!
        }.to change(Node, :count).by(5)
      end

      it 'creates new edges' do
        expect {
          TopologyService.new(map, network).create!
        }.to change(Edge, :count).by(6)
      end
    end

    context 'when attributes are invalid' do

      it 'dont creates new nodes' do
        expect {
          TopologyService.new(map, '').create!
        }.not_to change(Node, :count).by(5)
      end

      it 'dont creates new edges' do
        expect {
          TopologyService.new(map, '').create!
        }.not_to change(Edge, :count).by(6)
      end
    end
  end

end
