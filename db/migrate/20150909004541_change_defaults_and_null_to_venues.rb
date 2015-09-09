class ChangeDefaultsAndNullToVenues < ActiveRecord::Migration
  def change
    Venue.update_all number_phones: 0, post_roll_listens: 0, total_stories: 0
    change_column_null :venues, :number_phones, false
    change_column_default :venues, :number_phones, 0
    change_column_null :venues, :post_roll_listens, false
    change_column_default :venues, :post_roll_listens, 0
    change_column_null :venues, :total_stories, false
    change_column_default :venues, :total_stories, 0
  end
end
