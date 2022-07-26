class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at
  has_many :comments
  has_many :reactions
  has_many :reports
  belongs_to :user
end
