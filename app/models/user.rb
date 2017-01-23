class User < ActiveRecord::Base

  has_many :events

  acts_as_authentic do |c|
  end

  def full_name
    "#{self.first_name} #{self.surname}"
  end
end
