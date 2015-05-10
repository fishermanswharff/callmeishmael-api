class CreateUsersVenues < ActiveRecord::Migration

  def change
    create_table :users_venues
    add_column :users_venues, :venue_id, :integer, index: true
    add_column :users_venues, :user_id, :uuid, index: true
  end

end
