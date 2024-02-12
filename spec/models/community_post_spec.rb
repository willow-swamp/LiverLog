require 'rails_helper'

RSpec.describe CommunityPost, type: :model do
  let(:user) { create(:user) }

  describe 'バリデーションに通る' do
    context '投稿の保存に成功する' do
      it 'ユーザーIDがある' do
        community_post = build(:community_post, user:)
        expect(community_post).to be_valid
        expect(community_post.errors).to be_empty
      end
    end
  end

  describe 'バリデーションに失敗する' do
    context '投稿の保存に失敗する' do
      it '文字数が256文字を超える' do
        community_post = build(:community_post, content: 'a' * 257, user:)
        expect(community_post).to be_invalid
        expect(community_post.errors[:content]).to be_present
      end
    end
  end
end
