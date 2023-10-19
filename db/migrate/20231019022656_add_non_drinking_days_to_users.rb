class AddNonDrinkingDaysToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :non_drinking_days, :integer, array: true, default: []
  end
end
