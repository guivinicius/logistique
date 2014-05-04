require 'spec_helper'

describe MapsController do

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

  describe "POST 'create'" do

    let(:request_headers) do
      { 'HTTP_ACCEPT' => 'application/json', 'Content-Type' => 'application/json' }
    end

    context 'with valid parameters' do

      let(:valid_params) do
        { name: 'Test', network: network }
      end

      it 'responds successfully' do
        post :create, { map: valid_params }, request_headers
        expect(response.status).to eq(200)
      end

      it 'returns the new map name' do
        post :create, { map: valid_params }, request_headers
        expect(response.body).to include('Test')
      end

      it 'assigns @map' do
        post :create, { map: valid_params }, request_headers
        expect(assigns(:map)).to be_kind_of(Map)
      end

      it 'creates a new map' do
        expect {
          post :create, { map: valid_params }, request_headers
        }.to change(Map, :count).by(1)
      end

      it 'creates new nodes' do
        expect {
          post :create, { map: valid_params }, request_headers
        }.to change(Node, :count).by(5)
      end

      it 'creates new edges' do
        expect {
          post :create, { map: valid_params }, request_headers
        }.to change(Edge, :count).by(6)
      end
    end

    context 'with invalid parameters' do

      describe 'when passing no name' do

        it 'returns a error' do
          post :create, :network => network, :map => {:name => ''}
          expect(response.body).to include("can't be blank")
        end

      end

      describe 'when passing an existing name' do

        it 'returns a error' do
          create(:map, :name => "Public")
          post :create, :network => network, :map => {:name => 'Public'}
          expect(response.body).to include("has already been taken")
        end

      end

      describe 'when passing no network' do

        it 'returns a error' do
          post :create, :network => '', :map => {:name => 'Public'}
          expect(response.body).to include("network can't be empty")
        end

      end
    end

  end

  describe "GET 'best_route'" do
    let(:map)       { create(:map) }
    let!(:topology) { TopologyService.new(map, network).create! }

    context 'with valid parameters' do

      let(:valid_params) do
        {
          id: map.id,
          source: 'A',
          target: 'D',
          vehicle_autonomy: 10,
          fuel_price: 2.50
        }
      end

      it 'responds successfully' do
        get :best_route, valid_params
        expect(response.status).to eq(200)
      end

      it 'returns the best route' do
        get :best_route, valid_params
        expect(response.body).to include('A B D')
      end

      it 'returns the route cost' do
        get :best_route, valid_params
        expect(response.body).to include('6.25')
      end

    end

    context 'with invalid parameters' do

      context 'when passing a wrong source' do

        it 'returns an error' do
          params = { id: map.id, source: 'J', target: 'D', vehicle_autonomy: 10, fuel_price: 2.50 }
          get :best_route, params
          expect(response.body).to include("can't be blank")
        end

      end

      context 'when passing a wrong target' do

        it 'returns an error' do
          params = { id: map.id, source: 'A', target: 'J', vehicle_autonomy: 10, fuel_price: 2.50 }
          get :best_route, params
          expect(response.body).to include("can't be blank")
        end

      end

      context 'when passing a empty target' do

        it 'returns an error' do
          params = { id: map.id, source: 'A', target: '', vehicle_autonomy: 10, fuel_price: 2.50 }
          get :best_route, params
          expect(response.body).to include("can't be blank")
        end

      end

      context 'when passing a empty fuel_price' do

        it 'returns an error' do
          params = { id: map.id, source: 'A', target: 'D', vehicle_autonomy: 10, fuel_price: '' }
          get :best_route, params
          expect(response.body).to include("must be greater than 0")
        end

      end

      context 'when passing a empty vehicle_autonomy' do

        it 'returns an error' do
          params = { id: map.id, source: 'A', target: 'D', vehicle_autonomy: '', fuel_price: 2.50 }
          get :best_route, params
          expect(response.body).to include("must be greater than 0")
        end

      end

      context 'without target' do

        it 'returns an error' do
          params = { id: map.id, source: 'A', vehicle_autonomy: 10, fuel_price: 2.50 }
          get :best_route, params
          expect(response.body).to include("can't be blank")
        end

      end

      context 'without fuel_price' do

        it 'returns an error' do
          params = { id: map.id, source: 'A', target: 'D', vehicle_autonomy: 10 }
          get :best_route, params
          expect(response.body).to include("must be greater than 0")
        end

      end

    end

  end

end
