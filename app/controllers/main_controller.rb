class MainController < ApplicationController
  before_filter :signed_in_user
  
  def calendar
  end

end
