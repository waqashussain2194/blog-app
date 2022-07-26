FactoryBot.define do
  factory :suggestion do
    content { Faker::Lorem.characters(min_alpha: 5) }
  end
end
