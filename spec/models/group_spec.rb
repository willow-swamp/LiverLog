require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { create(:user) }

  describe 'バリデーションに通る' do
    context 'グループの保存に成功する' do
      it 'グループ名、グループ管理者ID、招待トークンがある' do
        group = build(:group, group_admin_id: user.id)
        expect(group).to be_valid
        expect(group.errors).to be_empty
      end
    end
  end

  describe 'バリデーションに失敗する' do
    context 'グループの保存に失敗する' do
      it 'グループ名がない' do
        group = build(:group, name: nil, group_admin_id: user.id)
        expect(group).to be_invalid
        expect(group.errors[:name]).to be_present
      end
      it 'グループ管理者IDがない' do
        group = build(:group, group_admin_id: nil)
        expect(group).to be_invalid
        expect(group.errors[:group_admin_id]).to be_present
      end
      it '招待トークンがない' do
        group = build(:group, invite_token: nil, group_admin_id: user.id)
        expect(group).to be_invalid
        expect(group.errors[:invite_token]).to be_present
      end
      it '招待トークンが重複している' do
        group = create(:group, group_admin_id: user.id)
        group2 = build(:group, invite_token: group.invite_token, group_admin_id: user.id)
        expect(group2).to be_invalid
        expect(group2.errors[:invite_token]).to be_present
      end
    end
  end
end
