class AddStorydetailsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :call_length, :string
    add_column :stories, :common_title, :string
    add_column :stories, :call_date, :date
  end
end
