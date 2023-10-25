require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  describe 'GET /index' do
  	context 'and if data is present' do
      before do
        FactoryBot.create_list(:property, 20)
        get '/api/v1/properties'
      end
      
      it 'returns all properties' do
        expect(json.size).to eq(20)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'but if no data is present' do
      before do
        get '/api/v1/properties'
      end
      
      it 'returns no property' do
        expect(json.size).to eq(0)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end