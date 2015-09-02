class CreatePhonelogs < ActiveRecord::Migration
  def change
    create_table :phonelogs do |t|
      t.text :log_content
      t.references :phone
      t.timestamps
    end
  end
end
