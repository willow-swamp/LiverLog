class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.references :drink_record, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
