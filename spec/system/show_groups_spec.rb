require 'rails_helper'

RSpec.describe "グループ詳細ページ", type: :system do
  let(:general_user) { create(:user) }
  let(:invitee) { create(:user, :invitee) }
  let(:group) { create(:group, group_admin_id: general_user.id) }

  describe "グループに所属していない場合" do
    before do
      skip_login_line(general_user)
    end
    context "プロフィールページの表示" do
      it "「グループなし」と表示される" do
        expect(page).to have_content "グループなし"
      end
    end
  end
  describe "グループに所属している場合" do
    before do
      group.users << general_user
      group.users << invitee
      skip_login_line(general_user)
    end
    context "グループ一覧の表示" do
      it "グループ名が表示される" do
        expect(page).to have_content group.name
      end
    end
    context "グループ詳細ページの表示" do
      before do
        click_link group.name
      end
      context "グループが作成されている場合" do
        it "グループ詳細ページへ遷移する" do
          expect(current_path).to eq group_path(group)
          expect(page).to have_content "グループ編集"
          expect(page).to have_content "グループ削除"
          expect(page).to have_content general_user.username
          expect(page).to have_content invitee.username
        end
        it "グループ名が表示されている" do
          expect(page).to have_content group.name
        end
      end
    end
  end
end
