class PropertySearchQuery
	attr_accessor :initial_scope

  def initialize(initial_scope = nil)
    @initial_scope = initial_scope || Property.all
  end


  def perform(params = {})
  	scoped = initial_scope
    scoped = filter_by_city(scoped, params[:city])
    scoped = filter_by_district(scoped, params[:district])
    scoped = filter_by_bedroom(scoped, params[:bedroom])
    scoped = filter_by_rent(scoped, params[:rent_gt], params[:rent_lt])
    scoped = filter_by_closest_mrt(scoped, params[:closest_mrt])
  end

  private

  def filter_by_city(scoped, city = nil)
  	city ? scoped.where(city: city) : scoped
  end

  def filter_by_district(scoped, district = nil)
  	return scoped unless district

  	district_list = district.split(',')
  	scoped.where(district: district_list)
  end

  def filter_by_bedroom(scoped, bedroom = nil)
 		bedroom ? scoped.where('bedroom <= ?', bedroom) : scoped
  end

  def filter_by_rent(scoped, rent_gt = nil, rent_lt = nil)
  	scoped = rent_gt ? scoped.where('rent >= ?', rent_gt) : scoped
  	rent_lt ? scoped.where('rent <= ?', rent_lt) : scoped
  end

  def filter_by_closest_mrt(scoped, closest_mrt = nil)
  	closest_mrt ? scoped.where(closest_mrt: closest_mrt) : scoped
  end
end