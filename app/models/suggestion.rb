# frozen_string_literal: true

class Suggestion < ApplicationRecord
  validates :user_id, :post_id, :content, presence: true
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  belongs_to :post
  resourcify
end
