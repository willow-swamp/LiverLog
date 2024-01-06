require 'rails_helper'

RSpec.describe "休肝日&飲酒日を記録する", type: :system do
  let(:user) { create(:user) }

  describe "休肝日を記録する" do
    before do
    login_line(user)
    click_link "drink-record-btn"
    end

    context "正しい値を入力した場合" do
      it "休肝日が記録される" do
        choose "休肝日"
        click_button "登録"
        expect(page).to have_content "記録を登録しました"
        expect(current_path).to eq profile_path
      end
    end
  end
end
