class AddMoreDetailsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :spoiler_alert, :boolean, null: false, default: false
    add_column :stories, :child_appropriate, :boolean, null: false, default: true
    add_column :stories, :explicit, :boolean, null: false, default: false
    add_column :stories, :gender, :string, null: false, default: 'Female'
    add_column :stories, :rating, :integer, null: false, default: 1
  end
end
