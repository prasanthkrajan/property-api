require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  describe 'GET /index' do
  	context 'and if data is present' do
      before do
        FactoryBot.create_list(:property, 20)
        get '/api/v1/properties'
      end
      
      it 'returns all properties' do
        expect(json.size).to eq(20)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'but if no data is present' do
      before do
        get '/api/v1/properties'
      end
      
      it 'returns no property' do
        expect(json.size).to eq(0)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /index with sorting params' do
  	context 'when sort by rent' do
  		let!(:cheapest_rent)       { FactoryBot.create(:property, rent: 200) }
      let!(:most_expensive_rent) { FactoryBot.create(:property, rent: 800) }
      let!(:mid_range_rent)      { FactoryBot.create(:property, rent: 500) }

  		context 'in asc order' do
  			before do
	        get '/api/v1/properties?sort_by=rent&sort_order=asc'
	      end

	      it 'returns all properties with rent in ascending order' do
          expect(json.size).to eq(3)
          expect(json[0]['rent']).to eql(cheapest_rent.rent.to_s)
          expect(json[1]['rent']).to eql(mid_range_rent.rent.to_s)
          expect(json[2]['rent']).to eql(most_expensive_rent.rent.to_s)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
  		end

  		context 'in desc order' do
  			before do
	        get '/api/v1/properties?sort_by=rent&sort_order=desc'
	      end

	      it 'returns all properties with rent in descending order' do
          expect(json.size).to eq(3)
          expect(json[0]['rent']).to eql(most_expensive_rent.rent.to_s)
          expect(json[1]['rent']).to eql(mid_range_rent.rent.to_s)
          expect(json[2]['rent']).to eql(cheapest_rent.rent.to_s)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
  		end
  	end

  	context 'when sort by floor size' do
  	end
  end
end