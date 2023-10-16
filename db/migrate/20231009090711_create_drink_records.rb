class CreateDrinkRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :drink_records do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :record_type, null: false
      t.datetime :start_time, null: false, unique: true
      t.string :drink_type
      t.integer :drink_volume
      t.integer :alcohol_percentage

      t.timestamps
    end
  end
end
