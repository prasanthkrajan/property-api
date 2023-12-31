require 'kimurai'

class PropertySpider < Kimurai::Base
  @engine = :selenium_firefox
  @start_urls = ["https://www.urhouse.com.tw/en/rentals"]

  def parse(response, url:, data: {})
  	puts 'response'
  	elements = []
  	doc = browser.current_response
  	doc.css('div.col-lg-4').each do |element|
  		elements << extract_data(element)
  	end
    218.times do
      browser.find("/html/body/div[2]/div/section[2]/div/div/div[2]/nav/ul/li[6]").click
      doc = browser.current_response
      doc.css('div.col-lg-4').each do |element|
        elements << extract_data(element)
      end
    end
    create_attributes = sanitize_data(elements)
    Property.create(create_attributes)
  end

  def sanitize_data(collection)
    PropertyPresenter.new(collection).present!
  end

  def extract_data(element)
    item = {}
    item[:image] = element.css('div.card-img-top').children[2].attributes['src'].value
    price_element = element.css('span.mr-2').first
    item[:price] = price_element.text
    item[:currency] = price_element.parent.children[0].text
    card_body_title_elements = element.css('div.card-body_title').children
    item[:title] = card_body_title_elements[0].text
    item[:address] = card_body_title_elements[2].text
    body_item_element = element.css('div.card-body_item').children
    item[:layout] = body_item_element[0].text
    item[:mrt] = body_item_element[2].text
    item
  end
end



