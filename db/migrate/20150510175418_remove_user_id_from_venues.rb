class RemoveUserIdFromVenues < ActiveRecord::Migration
  def change
    remove_column :venues, :user_id
  end
end
