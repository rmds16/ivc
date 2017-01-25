class AdminController < ApplicationController   
  layout "admin"
  before_filter :signed_in_admin_user
end