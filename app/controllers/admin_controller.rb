class AdminController < ApplicationController   
  layout "admin"
  before_action :signed_in_admin_user
end