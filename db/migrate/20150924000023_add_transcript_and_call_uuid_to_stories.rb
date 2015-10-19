class AddTranscriptAndCallUuidToStories < ActiveRecord::Migration
  def change
    add_column :stories, :transcript_url, :string
    add_column :stories, :call_uuid, :integer
    Story.all.update_attributes(transcript_url: 'http://www.google.com')
    Story.all.update_attributes(call_uuid: '000')
  end
end
