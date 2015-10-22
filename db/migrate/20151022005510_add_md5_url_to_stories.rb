class AddMd5UrlToStories < ActiveRecord::Migration
  def change
    add_column :stories, :md5_url, :string
  end
end
