# Property API

### Development Setup

1. Ensure you run `bundle install`, and `rake db:setup`, prior to `rails s`

2. If you wish to use scraped data from a chosen rental website, run `rake seed:scrape_ur_house_website`. If you prefer lighter, simpler data, please run `rake db:seed`

3. Your API should now be running on `localhost:3000`. To test it out, try acessing `http://localhost:3000/api/v1/docs`


