class AddVenuestatusToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :venue_status, :integer, null: false, default: 0
  end
end
