class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.text :unique_identifier, null: false, index: true
      t.text :name, null: false, index: true
      t.boolean :status, default: true
      t.integer :number_phones
      t.integer :post_roll_listens
      t.integer :total_stories
      t.belongs_to :user
      t.timestamps
    end
  end
end
