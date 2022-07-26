FactoryBot.define do
  factory :reaction do
    reaction_type { 'like' }
    likeable_type { 'Post' }
  end
end
