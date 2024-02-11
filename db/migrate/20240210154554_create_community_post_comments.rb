class CreateCommunityPostComments < ActiveRecord::Migration[7.0]
  def change
    create_table :community_post_comments do |t|
      t.text :message, null: false
      t.references :user, null: false, foreign_key: true
      t.references :community_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
