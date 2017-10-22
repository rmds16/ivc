class AddOrganiserReadToEventUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :events_users, :organiser_read, :boolean, default: false
  end
end
