class User < ActiveRecord::Base
  has_secure_password
  has_many :events, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :events_joined, through: :joins, source: :event
  validates :first_name, :last_name, :location, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :email, presence: true, uniqueness: { :case_sensitive => false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }, on: :update, allow_blank: true;
end
