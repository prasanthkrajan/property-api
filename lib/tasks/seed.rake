# frozen_string_literal: true

namespace :seed do
  desc 'Crawl through UR House website and scrape data'
  task scrape_ur_house_website: :environment do
  	Property.destroy_all
  	User.destroy_all
  	User.create(
			email: 'user@email.com',
			password: 'user1234'
		)

		User.create(
			email: 'admin@email.com',
			password: 'admin1234',
			admin: true
		)
    PropertySpider.crawl!
  end
end