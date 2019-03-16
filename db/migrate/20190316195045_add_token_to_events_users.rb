class AddTokenToEventsUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :events_users, :token, :string
  end
end
