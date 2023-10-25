require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  describe 'DELETE /destroy' do
    let!(:property_one)   { FactoryBot.create(:property) }
    let!(:property_two)   { FactoryBot.create(:property) }

  	context 'and if data is present' do
      before do
        delete "/api/v1/properties/#{property_two.id}"
      end
      
      it 'deletes and returns empty' do
        expect(json).to eq({})
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'but if no data is present' do
      before do
        delete "/api/v1/properties/#{property_two.id + property_one.id}"
      end
      
      it 'returns no property' do
        expect(json['id']).to be_nil
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end