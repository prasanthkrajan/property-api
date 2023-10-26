require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  describe 'POST /login' do
    let!(:user)   { FactoryBot.create(:user) }

    context 'when login is valid and belongs to user' do
      before do
        post "/api/v1/auth/login", params: { email: user.email, password: user.password }
      end

      it 'returns a valid auth token' do
        expect(json['auth_token']).not_to be_nil
        expect { JsonWebToken.decode(json['auth_token']) }.not_to raise_error
      end
    end

    context 'when login is invalid and has email that doesnt belong to any user' do
      before do
        post "/api/v1/auth/login", params: { email: 'bogative', password: user.password }
      end

      it 'returns a 401 error' do
        expect(json['error']).to eql('Unauthorized.')
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when login is invalid and has wrong password' do
      before do
        post "/api/v1/auth/login", params: { email: user.email, password: 'bogative' }
      end

      it 'returns a 401 error' do
        expect(json['error']).to eql('Unauthorized.')
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end