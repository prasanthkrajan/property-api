require 'kimurai'

class PropertySpider < Kimurai::Base
  @engine = :selenium_chrome
  @start_urls = ["https://www.urhouse.com.tw/en/rentals"]

  def parse(response, url:, data: {})
  	puts 'response'
  	puts response
  end
end

