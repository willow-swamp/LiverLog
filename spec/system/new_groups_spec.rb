require 'rails_helper'

RSpec.describe "グループを作成する", type: :system do
  let(:user) { create(:user) }

  before do
    skip_login_line(user)
    click_link "new-group"
  end

  describe "グループを作成する" do
    context "グループ名を入力する場合" do
      it "グループが作成される" do
        fill_in "group_name", with: "new_group"
        click_button "登録"
        expect(page).to have_content "グループを作成しました"
        expect(current_path).to eq group_path(Group.last)
        expect(page).to have_content "new_group"
      end
    end
    context "グループ名が空欄の場合" do
      it "グループが作成されない" do
        fill_in "group_name", with: ""
        click_button "登録"
        expect(page).to have_content "グループの作成に失敗しました"
        expect(current_path).to eq new_group_path
      end
    end
  end
end
