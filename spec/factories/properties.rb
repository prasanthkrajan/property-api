FactoryBot.define do
  factory :property do
    rent { Faker::Number.decimal }
    floor_size_in_ping { Faker::Number.decimal }
    floor_size_in_sqft { Faker::Number.decimal }
    currency { 'NT$' }
    full_address { 'Songgao Rd. Xinyi Dist., Taipei City' }
    type { 'residential' }
    bedroom { 5 }
    bathroom { 2 }
    closest_mrt { 'Dongmen' }
    city { 'Taipei City' }
    district { 'Xinyi' }
    title { 'MRT市政府/全新完工頂級純辦' }
    image_url { 'https://image.url' }
  end
end