class CreateCommunityPostLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :community_post_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :community_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
