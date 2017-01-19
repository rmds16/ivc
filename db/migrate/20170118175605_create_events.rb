class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.string :where
      t.string :post_map_ref
      t.string :country
      t.string :eventbrite_id
      t.string :web_link
      t.string :venue_web_link
      t.text :public_description
      t.text :private_description
      t.text :organiser
      t.text :how_to_find_us
      t.string :fee
      t.datetime :book_by_date
      t.integer :attendee_limit
      t.integer :user_id
      t.integer :display_level
      t.boolean :allow_bookings, default: false
      t.boolean :featured_event, default: false
      t.boolean :approved, default: false
      t.boolean :show_to_users
      t.timestamps null: false
    end
  end
end
