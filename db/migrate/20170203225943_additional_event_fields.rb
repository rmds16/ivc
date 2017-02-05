class AdditionalEventFields < ActiveRecord::Migration
  def up
    change_column :events, :organiser, :integer
  	add_column :events, :organiser_email, :string
    add_column :events, :organiser_phone, :string
    add_column :events, :second_organiser, :integer
    add_column :events, :second_organiser_email, :string
    add_column :events, :second_organiser_phone, :string
    remove_column :events, :private_description, :text
    remove_column :events, :how_to_find_us, :text
    remove_column :events, :attendee_limit, :integer
    remove_column :events, :display_level, :integer
    remove_column :events, :allow_bookings, :boolean
    remove_column :events, :venue_web_link, :string
    remove_column :events, :web_link, :string
    remove_column :events, :eventbrite_id, :string
    remove_column :events, :country, :string
  end

  def down
    change_column :events, :organiser, :text
    remove_column :events, :organiser_email, :string
    remove_column :events, :organiser_phone, :string
    remove_column :events, :second_organiser, :integer
    remove_column :events, :second_organiser_email, :string
    remove_column :events, :second_organiser_phone, :string
    add_column :events, :private_description, :text
    add_column :events, :how_to_find_us, :text
    add_column :events, :attendee_limit, :integer
    add_column :events, :display_level, :integer
    add_column :events, :allow_bookings, :boolean
    add_column :events, :venue_web_link, :string
    add_column :events, :web_link, :string
    add_column :events, :eventbrite_id, :string
    add_column :events, :country, :string
  end
end
