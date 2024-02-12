require 'rails_helper'

RSpec.describe CommunityPostComment, type: :model do
  let(:user) { create(:user) }
  let(:community_post) { create(:community_post, user:) }

  describe 'バリデーションに通る' do
    context '投稿の保存に成功する' do
      it 'ユーザーID、メッセージがある' do
        community_post_comment = build(:community_post_comment, user:, community_post:)
        expect(community_post_comment).to be_valid
        expect(community_post_comment.errors).to be_empty
      end
    end
  end

  describe 'バリデーションに失敗する' do
    context '投稿の保存に失敗する' do
      it '文字数が256文字を超える' do
        community_post_comment = build(:community_post_comment, message: 'a' * 257, user:, community_post:)
        expect(community_post_comment).to be_invalid
        expect(community_post_comment.errors[:message]).to be_present
      end
      it 'ユーザーIDがない' do
        community_post_comment = build(:community_post_comment, user: nil, community_post:)
        expect(community_post_comment).to be_invalid
        expect(community_post_comment.errors[:user]).to be_present
      end
      it '投稿IDがない' do
        community_post_comment = build(:community_post_comment, user:, community_post: nil)
        expect(community_post_comment).to be_invalid
        expect(community_post_comment.errors[:community_post]).to be_present
      end
    end
  end
end
