class AddTranscriptAndCallUuidToStories < ActiveRecord::Migration
  def change
    add_column :stories, :transcript_url, :string
    add_column :stories, :call_uuid, :integer
  end
end
