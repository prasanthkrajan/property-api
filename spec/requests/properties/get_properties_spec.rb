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

  describe 'GET /index with filter params' do
  	context 'when filtered by city' do
  		let!(:taipei_city_one)  { FactoryBot.create(:property, city: 'Taipei', rent: 1050) }
      let!(:hk_city)          { FactoryBot.create(:property, city: 'Hong Kong', rent: 400) }
      let!(:new_taipei_city)  { FactoryBot.create(:property, city: 'New Taipei', rent: 500) }
      let!(:taipei_city_two)  { FactoryBot.create(:property, city: 'Taipei', rent: 600) }

      context 'and data for the city is present' do
      	before do
	        get '/api/v1/properties?city=Taipei'
	      end

	      it 'returns all properties with filtered city, sorted by default rent in asc order' do
	        expect(json.size).to eq(2)
	        expect(json[0]['city']).to eql(taipei_city_two.city)
	        expect(json[1]['city']).to eql(taipei_city_one.city)
	      end

	      it 'returns status code 200' do
	        expect(response).to have_http_status(:success)
	      end
      end

      context 'but data for the city is not present' do
      	before do
	        get '/api/v1/properties?city=Beijing'
	      end

	      it 'returns no properties' do
	        expect(json.size).to eq(0)
	      end

	      it 'returns status code 200' do
	        expect(response).to have_http_status(:success)
	      end
      end
  	end

  	context 'when filtered by district' do
  		let!(:xinyi_district)  { FactoryBot.create(:property, district: 'Taipei', rent: 1050) }
      let!(:wanhua_district) { FactoryBot.create(:property, district: 'Wanhua', rent: 400) }
      let!(:daan_district)   { FactoryBot.create(:property, district: 'Daan', rent: 500) }
      let!(:beitou_district) { FactoryBot.create(:property, district: 'Beitou', rent: 600) }

      context 'and data for the district is present' do
      	before do
	        get '/api/v1/properties?district=Daan,Wanhua'
	      end

	      it 'returns all properties with filtered district, sorted by default rent in asc order' do
	        expect(json.size).to eq(2)
	        expect(json[0]['district']).to eql(wanhua_district.district)
	        expect(json[1]['district']).to eql(daan_district.district)
	      end

	      it 'returns status code 200' do
	        expect(response).to have_http_status(:success)
	      end
      end

      context 'but data for the district is not present' do
      	before do
	        get '/api/v1/properties?district=Beijing'
	      end

	      it 'returns no properties' do
	        expect(json.size).to eq(0)
	      end

	      it 'returns status code 200' do
	        expect(response).to have_http_status(:success)
	      end
      end
  	end

  	context 'when filtered by bedroom' do
  		let!(:two_bedrooms)   { FactoryBot.create(:property, bedroom: 2, rent: 1050) }
      let!(:four_bedrooms)  { FactoryBot.create(:property, bedroom: 4, rent: 400) }
      let!(:eight_bedrooms) { FactoryBot.create(:property, bedroom: 8, rent: 500) }
      let!(:five_bedrooms)  { FactoryBot.create(:property, bedroom: 5, rent: 600) }

      context 'and data for the bedroom is present' do
      	before do
	        get '/api/v1/properties?bedroom=7'
	      end

	      it 'returns all properties with filtered bedroom, sorted by default rent in asc order' do
	        expect(json.size).to eq(3)
	        expect(json[0]['bedroom']).to eql(four_bedrooms.bedroom)
	        expect(json[1]['bedroom']).to eql(five_bedrooms.bedroom)
	        expect(json[2]['bedroom']).to eql(two_bedrooms.bedroom)
	      end

	      it 'returns status code 200' do
	        expect(response).to have_http_status(:success)
	      end
      end

      context 'and data for the bedroom is not present' do
      	before do
	        get '/api/v1/properties?bedroom=1'
	      end

	      it 'returns no properties' do
	        expect(json.size).to eq(0)
	      end

	      it 'returns status code 200' do
	        expect(response).to have_http_status(:success)
	      end
      end
  	end

  	context 'when filtered by rent' do
  		let!(:unit_one)   { FactoryBot.create(:property, bedroom: 2, rent: 1050) }
      let!(:unit_two)   { FactoryBot.create(:property, bedroom: 4, rent: 400) }
      let!(:unit_three) { FactoryBot.create(:property, bedroom: 8, rent: 500) }
      let!(:unit_four)  { FactoryBot.create(:property, bedroom: 5, rent: 800) }

      context 'and both upper and lower bounds for the rent are present' do
      	before do
	        get '/api/v1/properties?rent_gt=600&rent_lt=1500'
	      end

	      it 'returns all properties with filtered rent, sorted by default rent in asc order' do
	        expect(json.size).to eq(2)
	        expect(json[0]['rent']).to eql(unit_four.rent.to_s)
	        expect(json[1]['rent']).to eql(unit_one.rent.to_s)
	      end

	      it 'returns status code 200' do
	        expect(response).to have_http_status(:success)
	      end
      end

      context 'and only lower bound for the rent are present' do
      	before do
	        get '/api/v1/properties?rent_gt=450'
	      end

	      it 'returns all properties with filtered rent, sorted by default rent in asc order' do
	        expect(json.size).to eq(3)
	        expect(json[0]['rent']).to eql(unit_three.rent.to_s)
	        expect(json[1]['rent']).to eql(unit_four.rent.to_s)
	        expect(json[2]['rent']).to eql(unit_one.rent.to_s)
	      end

	      it 'returns status code 200' do
	        expect(response).to have_http_status(:success)
	      end
      end

      context 'and only upper bound for the rent are present' do
      	before do
	        get '/api/v1/properties?rent_lt=700'
	      end

	      it 'returns all properties with filtered rent, sorted by default rent in asc order' do
	        expect(json.size).to eq(2)
	        expect(json[0]['rent']).to eql(unit_two.rent.to_s)
	        expect(json[1]['rent']).to eql(unit_three.rent.to_s)
	      end

	      it 'returns status code 200' do
	        expect(response).to have_http_status(:success)
	      end
      end

      context 'but no data is present for rent bounds' do
      	before do
	        get '/api/v1/properties?rent_gt=2000&rent_lt=3000'
	      end

	      it 'returns zero properties' do
	        expect(json.size).to eq(0)
	      end

	      it 'returns status code 200' do
	        expect(response).to have_http_status(:success)
	      end
      end
  	end

  	context 'when filtered by MRT line' do
  		let!(:mrt_one)   { FactoryBot.create(:property, closest_mrt: 'Dongmen', rent: 1050) }
      let!(:mrt_two)   { FactoryBot.create(:property, closest_mrt: 'Kunyang', rent: 400) }
      let!(:mrt_three) { FactoryBot.create(:property, closest_mrt: 'Dongmen', rent: 500) }
      let!(:mrt_four)  { FactoryBot.create(:property, closest_mrt: 'Taipei City Hall', rent: 800) }

      context 'and data for the closest_mrt is present' do
      	before do
	        get '/api/v1/properties?closest_mrt=Dongmen'
	      end

	      it 'returns all properties with filtered closest mrt, sorted by default rent in asc order' do
	        expect(json.size).to eq(2)
	        expect(json[0]['closest_mrt']).to eql(mrt_three.closest_mrt)
	        expect(json[1]['closest_mrt']).to eql(mrt_one.closest_mrt)
	      end

	      it 'returns status code 200' do
	        expect(response).to have_http_status(:success)
	      end
      end

      context 'but no data for the closest_mrt is present' do
      	before do
	        get '/api/v1/properties?closest_mrt=bogative'
	      end

	      it 'returns zero properties' do
	        expect(json.size).to eq(0)
	      end

	      it 'returns status code 200' do
	        expect(response).to have_http_status(:success)
	      end
      end
  	end
  end
end