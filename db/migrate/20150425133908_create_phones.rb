class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.text :unique_identifier, index: true
      t.text :token, null: false
      t.integer :status, null: false, default: 0, index: true
      t.text :wifiSSID
      t.text :wifiPassword
      t.timestamps
      t.belongs_to :venue, index: true
    end
  end
end
