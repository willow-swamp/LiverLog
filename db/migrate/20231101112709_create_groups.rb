class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.integer :group_admin_id, foreign_key: true, null: false

      t.timestamps
    end
    add_foreign_key :groups, :users, column: :group_admin_id
  end
end
