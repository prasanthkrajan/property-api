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

  		context 'in an unrecognised order' do
  			before do
	        get '/api/v1/properties?sort_by=rent&sort_order=bogative'
	      end

	      it 'returns all properties with rent in the default ascending order' do
          expect(json.size).to eq(3)
          expect(json[0]['rent']).to eql(cheapest_rent.rent.to_s)
          expect(json[1]['rent']).to eql(mid_range_rent.rent.to_s)
          expect(json[2]['rent']).to eql(most_expensive_rent.rent.to_s)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
  		end
  	end

  	context 'when sort by floor size in ping' do
  		let!(:smallest_unit)   { FactoryBot.create(:property, floor_size_in_ping: 200.3) }
      let!(:biggest_unit)    { FactoryBot.create(:property, floor_size_in_ping: 800) }
      let!(:mid_range_unit)  { FactoryBot.create(:property, floor_size_in_ping: 200.8) }

  		context 'in asc order' do
  			before do
	        get '/api/v1/properties?sort_by=floor_size_in_ping&sort_order=asc'
	      end

	      it 'returns all properties with floor_size_in_ping in ascending order' do
          expect(json.size).to eq(3)
          expect(json[0]['floor_size_in_ping']).to eql(smallest_unit.floor_size_in_ping.to_s)
          expect(json[1]['floor_size_in_ping']).to eql(mid_range_unit.floor_size_in_ping.to_s)
          expect(json[2]['floor_size_in_ping']).to eql(biggest_unit.floor_size_in_ping.to_s)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
  		end

  		context 'in desc order' do
  			before do
	        get '/api/v1/properties?sort_by=floor_size_in_ping&sort_order=desc'
	      end

	      it 'returns all properties with floor_size_in_ping in ascending order' do
          expect(json.size).to eq(3)
          expect(json[0]['floor_size_in_ping']).to eql(biggest_unit.floor_size_in_ping.to_s)
          expect(json[1]['floor_size_in_ping']).to eql(mid_range_unit.floor_size_in_ping.to_s)
          expect(json[2]['floor_size_in_ping']).to eql(smallest_unit.floor_size_in_ping.to_s)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
  		end

  		context 'in an unrecognised order' do
  			before do
	        get '/api/v1/properties?sort_by=floor_size_in_ping&sort_order=bogative'
	      end

	      it 'returns all properties with floor_size_in_ping in the default ascending order' do
          expect(json.size).to eq(3)
          expect(json[0]['floor_size_in_ping']).to eql(smallest_unit.floor_size_in_ping.to_s)
          expect(json[1]['floor_size_in_ping']).to eql(mid_range_unit.floor_size_in_ping.to_s)
          expect(json[2]['floor_size_in_ping']).to eql(biggest_unit.floor_size_in_ping.to_s)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
  		end
  	end


  	context 'when sort by floor size in sqft' do
  		let!(:smallest_unit)   { FactoryBot.create(:property, floor_size_in_sqft: 200.3) }
      let!(:biggest_unit)    { FactoryBot.create(:property, floor_size_in_sqft: 800) }
      let!(:mid_range_unit)  { FactoryBot.create(:property, floor_size_in_sqft: 200.8) }

  		context 'in asc order' do
  			before do
	        get '/api/v1/properties?sort_by=floor_size_in_sqft&sort_order=asc'
	      end

	      it 'returns all properties with floor_size_in_sqft in ascending order' do
          expect(json.size).to eq(3)
          expect(json[0]['floor_size_in_sqft']).to eql(smallest_unit.floor_size_in_sqft.to_s)
          expect(json[1]['floor_size_in_sqft']).to eql(mid_range_unit.floor_size_in_sqft.to_s)
          expect(json[2]['floor_size_in_sqft']).to eql(biggest_unit.floor_size_in_sqft.to_s)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
  		end

  		context 'in desc order' do
  			before do
	        get '/api/v1/properties?sort_by=floor_size_in_sqft&sort_order=desc'
	      end

	      it 'returns all properties with floor_size_in_sqft in ascending order' do
          expect(json.size).to eq(3)
          expect(json[0]['floor_size_in_sqft']).to eql(biggest_unit.floor_size_in_sqft.to_s)
          expect(json[1]['floor_size_in_sqft']).to eql(mid_range_unit.floor_size_in_sqft.to_s)
          expect(json[2]['floor_size_in_sqft']).to eql(smallest_unit.floor_size_in_sqft.to_s)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
  		end

  		context 'in an unrecognised order' do
  			before do
	        get '/api/v1/properties?sort_by=floor_size_in_sqft&sort_order=bogative'
	      end

	      it 'returns all properties with floor_size_in_sqft in the default ascending order' do
          expect(json.size).to eq(3)
          expect(json[0]['floor_size_in_sqft']).to eql(smallest_unit.floor_size_in_sqft.to_s)
          expect(json[1]['floor_size_in_sqft']).to eql(mid_range_unit.floor_size_in_sqft.to_s)
          expect(json[2]['floor_size_in_sqft']).to eql(biggest_unit.floor_size_in_sqft.to_s)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
  		end
  	end

  	context 'when sort by an unrecognised column' do
  		let!(:cheapest_rent)       { FactoryBot.create(:property, rent: 200) }
      let!(:most_expensive_rent) { FactoryBot.create(:property, rent: 800) }
      let!(:mid_range_rent)      { FactoryBot.create(:property, rent: 500) }

      before do
        get '/api/v1/properties?sort_by=bogative&sort_order=desc'
      end

      it 'returns all properties with the default sort column; rent in descending order' do
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
end