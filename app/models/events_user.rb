class EventsUser < ActiveRecord::Base
  belongs_to :attended_event, class_name: 'Event', foreign_key: :event_id
  belongs_to :attendee, class_name: 'User', foreign_key: :user_id

  before_create :generate_token

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless EventsUser.exists?(token: random_token)
    end
  end
end