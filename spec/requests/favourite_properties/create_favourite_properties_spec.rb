require 'rails_helper'

RSpec.describe 'FavouriteProperties', type: :request do  
  describe 'POST /create' do
    let!(:user)       { FactoryBot.create(:user) }
    let!(:property)   { FactoryBot.create(:property) }

    context 'when auth token is not present' do
      before do
        post "/api/v1/favourite_properties", params: { user_id: user.id, property_id: property.id }
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when a user tries to fav a property for another user' do
      let!(:new_user)       { FactoryBot.create(:user) }

      before do
        allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user)
        post "/api/v1/favourite_properties", params: { user_id: new_user.id, property_id: property.id }
      end

      it 'should raise an error and should not allow to be favourited again' do
        expect(json['error']).to eql('Forbidden. Not allowed')
        expect(FavouriteProperty.count).to eql(0)
      end

      it 'returns status code 403' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when a user tries to fav a non existent property' do
      before do
        allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user)
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

    context 'when params are invalid/null' do
      before do
        allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user)
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
        allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user)
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
        allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user)
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

    context 'when a user favourites a property, already favourited by another user' do
      let!(:new_user)       { FactoryBot.create(:user) }

      before do
        allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user)
        FactoryBot.create(:favourite_property, user: new_user, property: property)
        post "/api/v1/favourite_properties", params: { user_id: user.id, property_id: property.id }
      end

      it 'returns the fav property, and adds it to the new user favourite' do
        expect(json['user_id']).to eq(user.id)
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
        allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user)
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