# frozen_string_literal: true

class Post < ApplicationRecord
  scope :with_approval, -> { where(approved: true) }
  scope :without_approval, -> { where('approved = false') }

  validates :title, :user_id, presence: true
  paginates_per 3
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reactions, as: :likeable, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  resourcify
end
