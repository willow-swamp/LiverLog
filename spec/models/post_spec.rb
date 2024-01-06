require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:group) { create(:group, group_admin_id: user.id) }
  let(:drink_record) { create(:drink_record, user: user) }

  describe 'バリデーションに通る' do
    context '投稿の保存に成功する' do
      it 'ユーザーID、グループID、飲酒記録IDがある' do
        post = build(:post, user: user, group: group, drink_record: drink_record)
        expect(post).to be_valid
        expect(post.errors).to be_empty
      end
    end
  end

  describe 'バリデーションに失敗する' do
    context '投稿の保存に失敗する' do
      it '文字数が256文字を超える' do
        post = build(:post, content: 'a' * 257, user: user, group: group, drink_record: drink_record)
        expect(post).to be_invalid
        expect(post.errors[:content]).to be_present
      end
      it 'ユーザーIDがない' do
        post = build(:post, user: nil, group: group, drink_record: drink_record)
        expect(post).to be_invalid
        expect(post.errors[:user]).to be_present
      end
      it 'グループIDがない' do
        post = build(:post, user: user, group: nil, drink_record: drink_record)
        expect(post).to be_invalid
        expect(post.errors[:group]).to be_present
      end
      it '飲酒記録IDがない' do
        post = build(:post, user: user, group: group, drink_record: nil)
        expect(post).to be_invalid
        expect(post.errors[:drink_record]).to be_present
      end
    end
  end
end
