# frozen_string_literal: true

class User < ApplicationRecord
  validates :first_name, :last_name, :email, :password, presence: true
  rolify
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :trackable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reactions, as: :likeable, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
end
