require 'spec_helper'

describe Route do
  let(:map)   { create(:map) }

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

  let!(:topology) { TopologyService.new(map, network).create! }

  it 'is valid with valid attributes' do
    route = Route.new(map, 'A', 'D')
    expect(route).to be_valid
  end

  it 'is invalid with invalid attributes' do
    route = Route.new(map, 'A', 'J')
    expect(route).not_to be_valid
  end

  describe '#calculate' do


    context 'with a valid route' do
      it 'returns true' do
        expect(Route.new(map, 'A', 'D').calculate).to be_true
      end

      it 'assign a route value' do
        route = Route.new(map, 'A', 'D')
        expect {
          route.calculate
        }.to change { route.path }.to('A B D')
      end

      it 'assign a length value' do
        route = Route.new(map, 'A', 'D')
        expect {
          route.calculate
        }.to change { route.length }.to('25')
      end
    end

    context 'with a invalid route' do
      it 'returns false' do
        expect(Route.new(map, 'A', 'J').calculate).to be_false
      end
    end


  end

end
