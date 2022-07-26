# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, :user_id, :commentable_id, :commentable_type, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reactions, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  resourcify
end
