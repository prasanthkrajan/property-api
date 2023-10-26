require 'rails_helper'

RSpec.describe 'FavouriteProperties', type: :request do
  describe 'POST /create' do
    let!(:user)       { FactoryBot.create(:user) }
    let!(:property)   { FactoryBot.create(:property) }

    context 'when a user tries to fav a non existent property' do
      before do
        post "/api/v1/favourite_properties", params: { user_id: user.id, property_id: property.id + 1 }
      end

      it 'should raise an error and should not allow to be favourited again' do
        expect(json['error']).to eql('Validation failed: Property must exist')
        expect(FavouriteProperty.count).to eql(0)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when a non-existent user tries to fav a property' do
      before do
        post "/api/v1/favourite_properties", params: { user_id: user.id + 1, property_id: property.id }
      end

      it 'should raise an error and should not allow to be favourited again' do
        expect(json['error']).to eql('Validation failed: User must exist')
        expect(FavouriteProperty.count).to eql(0)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when params are invalid/null' do
      before do
        post "/api/v1/favourite_properties", params: { user_id: nil, property_id: nil }
      end

      it 'should raise an error and should not allow to be favourited again' do
        expect(json['error']).to eql('Validation failed: User must exist, Property must exist')
        expect(FavouriteProperty.count).to eql(0)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when a user favourites a new property' do
      before do
        post "/api/v1/favourite_properties", params: { user_id: user.id, property_id: property.id }
      end

      it 'returns the fav property' do
        expect(json['user_id']).to eq(user.id)
        expect(json['property_id']).to eq(property.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when a user has already favourited a property' do
      before do
        FactoryBot.create(:favourite_property, user: user, property: property)
        post "/api/v1/favourite_properties", params: { user_id: user.id, property_id: property.id }
      end

      it 'should raise an error and should not allow to be favourited again' do
        expect(json['error']).to eql('Validation failed: Property is already favorited')
        expect(FavouriteProperty.count).to eql(1)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when a new user favourites a property, already favourited by another user' do
      let!(:new_user)       { FactoryBot.create(:user) }
      before do
        FactoryBot.create(:favourite_property, user: user, property: property)
        post "/api/v1/favourite_properties", params: { user_id: new_user.id, property_id: property.id }
      end

      it 'returns the fav property, and adds it to the new user favourite' do
        expect(json['user_id']).to eq(new_user.id)
        expect(json['property_id']).to eq(property.id)
        expect(FavouriteProperty.count).to eql(2)
        expect(FavouriteProperty.pluck(:user_id)).to match_array([user.id, new_user.id])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when a user already has a favourite, and wants to favourite another new property' do
      let!(:new_property)       { FactoryBot.create(:property) }
      before do
        FactoryBot.create(:favourite_property, user: user, property: property)
        post "/api/v1/favourite_properties", params: { user_id: user.id, property_id: new_property.id }
      end

      it 'returns the fav property, and adds it to the user favourite' do
        expect(json['property_id']).to eq(new_property.id)
        expect(json['user_id']).to eq(user.id)
        expect(FavouriteProperty.count).to eql(2)
        expect(FavouriteProperty.pluck(:property_id)).to match_array([property.id, new_property.id])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end