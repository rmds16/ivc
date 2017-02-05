class Event < ActiveRecord::Base
  
  belongs_to :user
  has_and_belongs_to_many :attendees, class_name: 'User' 

  def as_json(current_user)
    {
	  title: title,
	  start: start_date,
	  end: end_date,
	  url: current_user.present? ? Rails.application.routes.url_helpers.event_path(id) : '',
	  color: featured_event? ? 'yellow' : '',
    }
  end

  def user_authorised?(user)
    user_id == user.id || organiser == user.id || second_organiser == user.id
  end

end
