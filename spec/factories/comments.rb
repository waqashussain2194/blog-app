FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.characters(min_alpha: 5) }
    commentable_type { 'Post' }
  end
end
