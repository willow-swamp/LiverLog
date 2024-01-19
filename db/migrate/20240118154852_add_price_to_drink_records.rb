class AddPriceToDrinkRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :drink_records, :price, :integer, null: false, default: 0
  end
end
