FactoryBot.define do
  factory :favourite_property do
    association :user
    association :property
  end
end
