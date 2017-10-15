class User < ActiveRecord::Base

  has_many :events
  has_and_belongs_to_many :attended_events, class_name: 'Event'
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
end
