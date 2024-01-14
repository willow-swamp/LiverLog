require 'rails_helper'

RSpec.describe "グループ編集・削除", type: :system do
  let(:general_user) { create(:user) }
  let(:invitee) { create(:user, :invitee) }
  let(:group) { create(:group, group_admin_id: general_user.id) }

  before do
    group.users << general_user
    group.users << invitee
    skip_login_line(general_user)
    click_link group.name
  end

  describe "グループを編集する" do
    context "グループ名を変更する場合" do
      before do
        click_link "グループ編集"
      end
      it "グループ名が変更される" do
        fill_in "group_name", with: "edit_group_name"
        click_button "登録"
        expect(page).to have_content "edit_group_name"
        expect(current_path).to eq group_path(group)
      end
      it "グループ名が変更されない" do
        fill_in "group_name", with: ""
        click_button "登録"
        expect(page).to have_content "グループの更新に失敗しました"
        expect(current_path).to eq edit_group_path(group)
      end
    end
  end

  describe "グループを削除する" do
    context "グループを削除する場合" do
      before do
        click_link "グループ削除"
      end
      it "グループが削除される" do
        expect(page).to have_content "グループを削除しました"
        expect(current_path).to eq profile_path
        expect(page).not_to have_content group.name
        expect(page).not_to have_content invitee.username
        expect(page).to have_content "グループなし"
      end
    end
  end
end
