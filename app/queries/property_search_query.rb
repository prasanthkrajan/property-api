class PropertySearchQuery
	include HasScope

  has_scope :by_city

  def perform(params = {})
    apply_scopes(collection, params)
  end

  def collection
  	Property
  end
end