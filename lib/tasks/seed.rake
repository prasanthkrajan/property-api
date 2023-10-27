# frozen_string_literal: true

namespace :seed do
  desc 'Crawl through UR House website and scrape data'
  task scrape_ur_house_website: :environment do
  	Property.destroy_all
    PropertySpider.crawl!
  end
end