class ChangeEventsShowDefault < ActiveRecord::Migration
  def change
  	change_column_default :events, :show_to_users, false
  end
end
