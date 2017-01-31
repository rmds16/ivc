class Event < ActiveRecord::Base
  
  belongs_to :user
  has_and_belongs_to_many :attendees, class_name: 'User' 

  def as_json(options={})
    {
	  title: title,
	  start: start_date,
	  end: end_date,
	  url: Rails.application.routes.url_helpers.event_path(id),
	  color: featured_event? ? 'yellow' : 'blue',
	  color: featured_event? ? 'yellow' : '',
    }
  end

end
