class CreateCommunityPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :community_posts do |t|
      t.text :content, null: false
      t.string :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
