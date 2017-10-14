class AddEventsUsersIdToAhoyMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :ahoy_messages, :events_users_id, :integer
  end
end
