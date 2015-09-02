class AddColumnTotalListensToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :total_listens, :integer
  end
end
