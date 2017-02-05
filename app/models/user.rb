class User < ActiveRecord::Base

  has_many :events
  has_and_belongs_to_many :attended_events, class_name: 'Event'

  acts_as_authentic do |c|
  end

  def as_json(options = {})
    {
	  email: email
    }
  end

  def full_name
    "#{self.first_name} #{self.surname}"
  end

  def future_events
    attended_events.where("start_date > ?", Time.now ).order(:start_date)
  end
end
