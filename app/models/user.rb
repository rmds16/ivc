class User < ActiveRecord::Base

  has_many :events_users
  has_many :messages, class_name: "Ahoy::Message"
  has_many :events
  has_many :attended_events, through: :events_users, class_name: 'Event'
  belongs_to :event

  acts_as_authentic do |c|
  end

  validates :first_name, presence: true
  validates :surname, presence: true

  def as_json(options = {})
    {
	  email: email,
	  phone: phone
    }
  end

  def self.organisers
    User.all.map { |u| [u.full_name, u.id] }
  end

  def full_name
    "#{self.first_name} #{self.surname}"
  end

  def future_events
    attended_events.where("start_date > ?", Time.now ).order(:start_date)
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset_instructions(self).deliver_now
  end

  def tracking_message_for_event(event)
    events_user = EventsUser.where(event_id: event.id, user_id: id).order(:id).last
    messages.find_by(events_users_id: events_user&.id)
  end
end
