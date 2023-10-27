class PropertyPresenter
	attr_accessor :collection

	def initialize(collection = [])
		@collection = collection
	end

	def present!
		collection.map { |element| sanitize_data(element) }
	end

	def sanitize_data(element)
		{
			rent: element[:price].gsub(",","").to_f,
			currency: element[:currency].strip,
			full_address: element[:address],
			unit_type: 'residential',
			floor_size_in_ping: element[:layout].split('Ping')[0].strip.to_f,
			floor_size_in_sqft: element[:layout].partition("Ping (")[2].split("sq.ft")[0].strip.to_f,
			city: element[:address].split(',').last.split(' ').first.strip,
			district: element[:address].split(' Dist').first.split('.').last.strip,
			title: element[:title],
			image_url: element[:image],
			bathroom: element[:layout].partition('sq.ft)').last.strip.split(' Bath')[0].to_i,
			bedroom: element[:layout].partition(' Bed').first.split(' ').last.to_i,
			closest_mrt: element[:mrt].split("\n").first.strip.split('MRT： ').last
		}
	end
end