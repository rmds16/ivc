class User < ActiveRecord::Base

  has_many :events
  has_and_belongs_to_many :attended_events, class_name: 'Event'

  acts_as_authentic do |c|
  end

  def full_name
    "#{self.first_name} #{self.surname}"
  end
end
