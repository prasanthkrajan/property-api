class Property < ApplicationRecord
	has_many :favorite_properties, dependent: :destroy

	scope :by_city, -> city { where(city: city) }
	scope :by_district, -> (value) { where(district: value) }
	scope :by_bedroom, -> (from, to) { where("bedroom >= ? AND bedroom <= ?", from, to) }
	scope :by_rent, -> (from, to) { where("rent >= ? AND rent <= ?", from, to) }
	scope :by_closest_mrt, -> (value) { where(closest_mrt: value) }
end
