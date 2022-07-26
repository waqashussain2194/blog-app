# frozen_string_literal: true

class Reaction < ApplicationRecord
  validates :likeable_id, :likeable_type, :user_id, presence: true
  validates :user_id, uniqueness: { scope: %i[likeable_id likeable_type] }
  belongs_to :likeable, polymorphic: true
  belongs_to :user
  resourcify
end
