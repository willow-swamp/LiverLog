require 'rails_helper'

RSpec.describe PostComment, type: :model do
  let(:user) { create(:user) }
  let(:group) { create(:group, group_admin_id: user.id) }
  let(:drink_record) { create(:drink_record, user: user) }
  let(:post) { create(:post, user: user, group: group, drink_record: drink_record) }

  describe 'バリデーションに通る' do
    context '投稿の保存に成功する' do
      it 'ユーザーID、投稿ID、メッセージがある' do
        post_comment = build(:post_comment, user: user, post: post)
        expect(post_comment).to be_valid
        expect(post_comment.errors).to be_empty
      end
    end
  end

  describe 'バリデーションに失敗する' do
    context '投稿の保存に失敗する' do
      it '文字数が256文字を超える' do
        post_comment = build(:post_comment, message: 'a' * 257, user: user, post: post)
        expect(post_comment).to be_invalid
        expect(post_comment.errors[:message]).to be_present
      end
      it 'ユーザーIDがない' do
        post_comment = build(:post_comment, user: nil, post: post)
        expect(post_comment).to be_invalid
        expect(post_comment.errors[:user]).to be_present
      end
      it '投稿IDがない' do
        post_comment = build(:post_comment, user: user, post: nil)
        expect(post_comment).to be_invalid
        expect(post_comment.errors[:post]).to be_present
      end
    end
  end
end
