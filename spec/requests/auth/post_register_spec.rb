require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  describe 'POST /register' do
    let!(:user)   { FactoryBot.create(:user) }

    context 'when email and password is valid and doesnt belong to any user yet' do
      before do
        post "/api/v1/auth/register", params: { email: 'newuser@email.com', password: 'newuserpassword' }
      end

      it 'returns a valid auth token' do
        expect(json).to eql('x')
      end
    end

    # context 'when login is invalid and has email that doesnt belong to any user' do
    #   before do
    #     post "/api/v1/auth/login", params: { email: 'bogative', password: user.password }
    #   end

    #   it 'returns a 401 error' do
    #     expect(json['error']).to eql('Unauthorized.')
    #     expect(response).to have_http_status(:unauthorized)
    #   end
    # end

    # context 'when login is invalid and has wrong password' do
    #   before do
    #     post "/api/v1/auth/login", params: { email: user.email, password: 'bogative' }
    #   end

    #   it 'returns a 401 error' do
    #     expect(json['error']).to eql('Unauthorized.')
    #     expect(response).to have_http_status(:unauthorized)
    #   end
    # end
  end
end