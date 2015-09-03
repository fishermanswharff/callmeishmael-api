class AddColumnTotalListensToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :total_listens, :integer, null: false, default: 0
  end
end
