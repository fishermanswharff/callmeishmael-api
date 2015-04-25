class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.text :unique_identifier, index: true
      t.text :name, null: false, index: true
      t.boolean :status, default: true
      t.integer :number_phones
      t.integer :post_roll_listens
      t.integer :total_stories
      t.uuid :user_id
      t.timestamps
    end
  end
end
