require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  describe 'PUT /update' do
    let!(:user)           { FactoryBot.create(:user) }
    let!(:admin_user)     { FactoryBot.create(:user, :admin) }
    let!(:property_one)   { FactoryBot.create(:property) }
    let!(:property_two)   { FactoryBot.create(:property) }

    context 'when auth token is not present' do
      let!(:previous_rent) { property_two.rent }
      let!(:new_rent)      { property_two.rent + 500 }

      before do
        put "/api/v1/properties/#{property_two.id}", params: { property: { rent: new_rent } }
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

  	context 'and if data is present' do
      context 'and user is an admin' do
        before do
          allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(admin_user)
        end

        context 'and update params are valid' do
          let!(:previous_rent) { property_two.rent }
          let!(:new_rent)      { property_two.rent + 500 }

          before do
            put "/api/v1/properties/#{property_two.id}", params: { property: { rent: new_rent } }
          end
          
          it 'updates the field and returns the property' do
            expect(json['id']).to eq(property_two.id)
            expect(json['rent']).to eq(new_rent.to_s)
          end

          it 'returns status code 200' do
            expect(response).to have_http_status(:success)
          end
        end

        context 'but update params are not valid' do
          before do
            put "/api/v1/properties/#{property_two.id}", params: { property: { bogative: 'bogative' } }
          end
          
          it 'returns the property without making changes' do
            expect(json['id']).to eq(property_two.id)
          end

          it 'returns status code 200' do
            expect(response).to have_http_status(:success)
          end
        end

        context 'but update params are malformed' do
          before do
            put "/api/v1/properties/#{property_two.id}", params: { bogative: 'bogative' }
          end
          
          it 'returns the property without making changes' do
            expect(json['id']).to eq(property_two.id)
          end

          it 'returns status code 200' do
            expect(response).to have_http_status(:success)
          end
        end
      end

      context 'but user is not an admin' do
        context 'and update params are valid' do
          let!(:previous_rent) { property_two.rent }
          let!(:new_rent)      { property_two.rent + 500 }

          before do
            allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user)
            put "/api/v1/properties/#{property_two.id}", params: { property: { rent: new_rent } }
          end
          
          it 'does not update data' do
            expect(json['error']).to eql('Forbidden. Not allowed')
          end

          it 'returns status code 403' do
            expect(response).to have_http_status(:forbidden)
          end
        end
      end
    end

    context 'but if no data is present' do
      before do
        allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user)
        get "/api/v1/properties/#{property_two.id + property_one.id}"
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