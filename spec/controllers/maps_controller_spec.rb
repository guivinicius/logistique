require 'spec_helper'

describe MapsController do

  describe "POST 'create'" do

    let(:request_headers) do
      { 'HTTP_ACCEPT' => 'application/json', 'Content-Type' => 'application/json' }
    end

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

end
