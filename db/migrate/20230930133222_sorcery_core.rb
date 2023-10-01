class SorceryCore < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false 
      t.string :image
      t.integer :role, null: false, default: 0
      t.text :comment
      t.boolean :remainder, null: false, default: false
      t.boolean :first_login, null: false, default: true

      t.timestamps                null: false
    end
  end
end
