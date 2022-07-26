FactoryBot.define do
  factory :report do
    content { Faker::Lorem.characters(min_alpha: 5) }
    reportable_type { 'Post' }
  end
end
