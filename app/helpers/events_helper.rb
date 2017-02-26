module EventsHelper

  def select_day_of_week(day_selected = DateTime.now.wday)
    @days = []
    Date::DAYNAMES.each_with_index { |x, i| @days << [x, i] }
  	select_tag(:day_of_week, options_for_select(@days, selected: day_selected) )
  end

end
