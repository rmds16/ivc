class Event < ActiveRecord::Base
  
  belongs_to :user

  def as_json(options={})
    {
	  title: title,
	  start: start_date,
	  end: end_date
    }
  end

end
