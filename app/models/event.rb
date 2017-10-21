class Event < ActiveRecord::Base
  
  has_many :events_users
  belongs_to :user
  belongs_to :organiser, class_name: 'User', foreign_key: :organiser_id
  belongs_to :second_organiser, class_name: 'User', foreign_key: :second_organiser_id
  has_many :attendees, through: :events_users, class_name: 'User'

  validates :title, presence: true
  validates_date :start_date
  validates :organiser_id, numericality: { only_integer: true, message: "please select an organiser" }

  def as_json(current_user)
    {
	  title: title,
    tooltip: current_user.present? ? title : "Please sign in to view details",
	  start: start_date,
	  end: end_date,
	  url: Rails.application.routes.url_helpers.event_path(id),
	  className: featured_event? ? 'featured-event' : 'standard-event'
    }
  end

  def user_authorised?(user)
    user.admin? || user_id == user.id || organiser_id == user.id || second_organiser_id == user.id
  end

  def start_date_humanized
    start_date.strftime("%A #{start_date.day.ordinalize} %B %G") if start_date
  end
end
