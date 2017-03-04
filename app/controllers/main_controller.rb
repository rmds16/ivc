class MainController < ApplicationController
  layout :resolve_layout
  
  def calendar
    @current_date = session[:calendar] ? session[:calendar] : Time.now.to_i*1000
  end

  def introduction
  end

  def events_and_activities
  end

  def membership
  end

  def contacts
  end

  def bedford
  end

  def south_bedfordshire
  end

  def st_albans
  end

  def contacts
  end

  def mid_hertfordshire
  end

  def west_hertfordshire
  end

  def north_hertfordshire
  end

  def other_areas
  end

  def evening_events
    @title = "Evening Events"
    @image = "photo_page_eveningsout_1.jpg"
    render 'main/photo_gallery'
  end

  def days_out
    @title = "Days Out"
    @image = "photo_page_daysout.jpg"
    render 'main/photo_gallery'
  end

  def walks
    @title = "Walks"
    @image = "photo_page_walks_1.jpg"
    render 'main/photo_gallery'
  end

  def city_breaks
    @title = "City Breaks"
    @image = "photo_page_city_weekends.jpg"
    render 'main/photo_gallery'
  end

  def activity_weekends
    @title = "Activity Weekends"
    @image = "photo_page_weekends.jpg"
    render 'main/photo_gallery'
  end

  def trips_abroad
    @title = "Trips Abroad"
    @image = "photo_page_europe.jpg"
    render 'main/photo_gallery'
  end

  def weekends_away
    @title = "Weekends Away"
    @image = "photo_page_swanage1.jpg"
    render 'main/photo_gallery'
  end

  def activities
    @title = "Activities"
    @image = "activities_photo_page.jpg"
    render 'main/photo_gallery'
  end
end

private   

def resolve_layout
  case action_name
   when "calendar"
    "application"
   else 
    "main"
   end
end