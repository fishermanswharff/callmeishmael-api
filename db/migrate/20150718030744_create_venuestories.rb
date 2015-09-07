class CreateVenuestories < ActiveRecord::Migration
  def change
    create_table :venuestories do |t|
      t.belongs_to :venue, index: true
      t.belongs_to :story, index: true
      t.timestamps
    end
    add_foreign_key :venuestories, :venues, on_delete: :cascade
    add_foreign_key :venuestories, :stories, on_delete: :cascade
  end
end
