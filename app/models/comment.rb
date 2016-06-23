class Comment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  validates :comment, :event_id, :user_id, presence: true
  validates :comment, length: { minimum: 5 }
end
