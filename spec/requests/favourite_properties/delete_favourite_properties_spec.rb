require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  describe 'DELETE /destroy' do
    let!(:fav_property_one)   { FactoryBot.create(:favourite_property) }
    let!(:fav_property_two)   { FactoryBot.create(:favourite_property) }

  	context 'and if data is present' do
      before do
        delete "/api/v1/favourite_properties/#{fav_property_two.id}"
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
        delete "/api/v1/favourite_properties/#{fav_property_two.id + fav_property_one.id}"
      end
      
      it 'returns no fav property' do
        expect(json['id']).to be_nil
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end