class Event < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :organiser, class_name: 'User', foreign_key: :organiser_id
  belongs_to :second_organiser, class_name: 'User', foreign_key: :second_organiser_id
  has_and_belongs_to_many :attendees, class_name: 'User'


  def as_json(current_user)
    {
	  title: title,
	  start: start_date,
	  end: end_date,
	  url: current_user.present? ? Rails.application.routes.url_helpers.event_path(id) : '',
	  className: featured_event? ? 'featured-event' : 'standard-event'
    }
  end

  def user_authorised?(user)
    user_id == user.id || organiser_id == user.id || second_organiser_id == user.id
  end

end
