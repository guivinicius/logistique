require 'spec_helper'

describe DeliveryCostService do

  let(:length) { 25 }

  describe "#cost" do

    context 'when attributes are valid' do

      it 'returns the right cost' do
        expect(DeliveryCostService.new(length, 10, 2.50).cost).to eq(6.25)
      end
    end

    context 'when length is 0' do

      it 'returns an error on length' do
        expect(DeliveryCostService.new(0, 10, 2.50).cost).to have(1).error_on(:length)
      end

    end

    context 'when vehicle_autonomy is 0' do

      it 'returns an error on vehicle_autonomy' do
        expect(DeliveryCostService.new(25, 0, 2.50).cost).to have(1).error_on(:vehicle_autonomy)
      end

    end

    context 'when fuel_price is 0' do

      it 'returns an error on length' do
        expect(DeliveryCostService.new(25, 10, 0).cost).to have(1).error_on(:fuel_price)
      end

    end

  end

end
