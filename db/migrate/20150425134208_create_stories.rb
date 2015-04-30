class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.text :unique_identifier, index: true
      t.text :title, null: false, required: true
      t.text :url, null: false, required: true
      t.integer :story_type, null: false, default: 1, index: true
      t.text :author_last
      t.text :author_first
      t.integer :placements
      t.integer :listens
      t.decimal :percentage, precision: 4, scale: 2
      t.timestamps
    end
  end
end
