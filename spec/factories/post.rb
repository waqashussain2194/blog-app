FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(min_alpha: 5) }
    content { Faker::Lorem.characters(min_alpha: 5) }
  end
end
