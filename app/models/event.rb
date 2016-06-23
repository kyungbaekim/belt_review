class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :users_joined, through: :joins, source: :user
  has_many :users_commented, through: :comments, source: :user
  validates :event_name, :event_date, :event_location, :event_state, :user_id, presence: true
  validates :event_name, length: { minimum: 5 }
end
