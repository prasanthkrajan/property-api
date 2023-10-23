# frozen_string_literal: true

namespace :seed do
  desc 'Crawl through UR House website and scrape data'
  task scrape_ur_house_website: :environment do
    PropertySpider.crawl!
  end
end