require 'rails_helper'

RSpec.describe 'FavouriteProperties', type: :request do
  describe 'GET /index' do
    let!(:user)               { FactoryBot.create(:user) }
    let!(:another_user)       { FactoryBot.create(:user) }
    let!(:fav_property_one)   { FactoryBot.create(:favourite_property, user: user) }
    let!(:fav_property_two)   { FactoryBot.create(:favourite_property, user: user) }
    let!(:fav_property_three) { FactoryBot.create(:favourite_property, user: another_user) }
    let!(:fav_property_four)  { FactoryBot.create(:favourite_property, user: user) }

    context 'when auth token is not present' do
      before do
        get "/api/v1/favourite_properties"
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when auth token is present' do
      before do
        allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user)
        get "/api/v1/favourite_properties"
      end

      it 'returns all fav properties that belong to current user' do
        expect(json.size).to eq(3)
        expect(json[0]['property_id']).to eql(fav_property_four.property_id)
        expect(json[1]['property_id']).to eql(fav_property_two.property_id)
        expect(json[2]['property_id']).to eql(fav_property_one.property_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end