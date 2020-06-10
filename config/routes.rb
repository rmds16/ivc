=begin
 June 2020    Modified to remove area pages and include new photo pages
=end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "main#introduction"
  
  match 'calendar' => 'main#calendar', via: %i{get}
  match 'introduction' => 'main#introduction', via: %i{get}
  match 'events_and_activities' => 'main#events_and_activities', via: %i{get}
  match 'membership' => 'main#membership', via: %i{get}
  match 'contacts' => 'main#contacts', via: %i{get}
  match 'bedford' => 'main#bedford', via: %i{get}
  match 'south_bedfordshire' => 'main#south_bedfordshire', via: %i{get}
  match 'st_albans' => 'main#st_albans', via: %i{get}
  match 'contacts' => 'main#contacts', via: %i{get}
  match 'mid_hertfordshire' => 'main#mid_hertfordshire', via: %i{get}
  match 'west_hertfordshire' => 'main#west_hertfordshire', via: %i{get}
  match 'north_hertfordshire' => 'main#north_hertfordshire', via: %i{get}
  match 'areas_covered' => 'main#areas_covered', via: %i{get}

  match 'evening_events' => 'main#evening_events', via: %i{get}
  match 'days_out' => 'main#days_out', via: %i{get}
  match 'walks' => 'main#walks', via: %i{get}
  match 'seaside_breaks' => 'main#seaside_breaks', via: %i{get}
  match 'houses_gardens' => 'main#houses_gardens', via: %i{get}
  match 'trips_abroad' => 'main#trips_abroad', via: %i{get}
  match 'weekends_away' => 'main#weekends_away', via: %i{get}
  match 'activities' => 'main#activities', via: %i{get}
end
