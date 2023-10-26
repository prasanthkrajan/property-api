require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  describe 'DELETE /destroy' do
    let!(:fav_property_one)   { FactoryBot.create(:favourite_property) }
    let!(:fav_property_two)   { FactoryBot.create(:favourite_property) }

  	context 'and if data is present' do
      context 'and data belongs to user' do
        before do
          allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(fav_property_two.user)
          delete "/api/v1/favourite_properties/#{fav_property_two.id}"
        end
        
        it 'deletes and returns empty' do
          expect(json).to eq({})
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(:no_content)
        end
      end

      context 'but data does not belong to user' do
        let!(:new_user)       { FactoryBot.create(:user) }

        before do
          allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(new_user)
          delete "/api/v1/favourite_properties/#{fav_property_two.id}"
        end
        
        it 'does not delete data' do
          expect(json['error']).to eql('Forbidden. Not allowed')
          expect(FavouriteProperty.count).to eql(2)
        end

        it 'returns status code 403' do
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'but if no data is present' do
      before do
        allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(fav_property_two.user)
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