require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  describe 'POST /register' do
    
    context 'when credentials are valid' do
      before do
        post '/api/v1/auth/register', params: { email: Faker::Internet.email, password: Faker::Internet.password }
      end

      it 'returns a valid auth token' do
        expect(json['auth_token']).not_to be_nil
        expect { JsonWebToken.decode(json['auth_token']) }.not_to raise_error
      end
    end

    context 'when there are existing users with the same email' do
      let!(:user)   { FactoryBot.create(:user) }

      before do
        post '/api/v1/auth/register', params: { email: user.email, password: 'random1234' }
      end

      it 'returns a 422 error' do
        expect(json['error']).to eql("Validation failed: Email has already been taken")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when email is blank' do
      before do
        post '/api/v1/auth/register', params: { email: '', password: 'random1234' }
      end

      it 'returns a 422 error' do
        expect(json['error']).to eql("Validation failed: Email can't be blank")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end