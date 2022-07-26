# frozen_string_literal: true

class Report < ApplicationRecord
  validates :user_id, :reportable_id, :reportable_type, presence: true
  belongs_to :reportable, polymorphic: true
  belongs_to :user
end
