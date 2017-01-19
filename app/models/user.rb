class User < ActiveRecord::Base

  has_many :events

  acts_as_authentic do |c|
  end
end
