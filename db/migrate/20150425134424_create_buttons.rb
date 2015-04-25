class CreateButtons < ActiveRecord::Migration
  def change
    create_table :buttons do |t|
      t.text :assignment, null: false, index: true
      t.belongs_to :phone, index: true
      t.belongs_to :story, index: true
      t.timestamps
    end
  end
end
