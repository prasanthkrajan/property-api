require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  describe 'DELETE /destroy' do
    let!(:user)           { FactoryBot.create(:user) }
    let!(:admin_user)     { FactoryBot.create(:user, :admin) }
    let!(:property_one)   { FactoryBot.create(:property) }
    let!(:property_two)   { FactoryBot.create(:property) }

    context 'when auth token is not present' do
      before do
        delete "/api/v1/properties/#{property_two.id}"
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

  	context 'and if data is present' do
      context 'and user is an admin' do
        before do
          allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(admin_user)
          delete "/api/v1/properties/#{property_two.id}"
        end
        
        it 'deletes and returns empty' do
          expect(json).to eq({})
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(:no_content)
        end
      end

      context 'but user is not admin' do
        before do
          allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user)
          delete "/api/v1/properties/#{property_two.id}"
        end
        
        it 'does not delete data' do
          expect(json['error']).to eql('Forbidden. Not allowed')
          expect(Property.count).to eql(2)
        end

        it 'returns status code 403' do
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'but if no data is present' do
      before do
        allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(admin_user)
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