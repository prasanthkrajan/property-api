class PropertySearchQuery
	attr_accessor :initial_scope, :params

  def initialize(params = {}, initial_scope = Property.all)
    @initial_scope = initial_scope 
    @params = params
  end


  def perform!
  	scoped = initial_scope
    scoped = filter_by_city(scoped, params[:city])
    scoped = filter_by_district(scoped, params[:district])
    scoped = filter_by_bedroom(scoped, params[:bedroom])
    scoped = filter_by_rent(scoped, params[:rent_gt], params[:rent_lt])
    scoped = filter_by_closest_mrt(scoped, params[:closest_mrt])
    scoped = sort(scoped, params[:sort_by], params[:sort_order])
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
  	closest_mrt ? scoped.where("closest_mrt ILIKE ?", "%#{closest_mrt}%") : scoped
  end

  def sort(scoped, sort_by, sort_order)
    sort_order = %w[asc desc].include?(sort_order) ? sort_order : 'asc'
  	sort_by = Property.column_names.include?(sort_by) ? sort_by : 'rent'
  	
  	scoped.order(sort_by => sort_order)
  end
end