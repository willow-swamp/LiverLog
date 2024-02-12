require 'rails_helper'

RSpec.describe '利用規約とプライバシーポリシーの表示', type: :system do
  describe '利用規約の表示' do
    context 'ログイン前' do
      before do
        visit root_path
      end
      it '利用規約のリンクが表示される' do
        click_link '利用規約'
        expect(page).to have_content '利用規約'
      end
      it 'プライバシーポリシーのリンクが表示される' do
        click_link 'プライバシーポリシー'
        expect(page).to have_content 'プライバシーポリシー'
        expect(current_path).to eq privacy_policy_path
      end
    end
    context 'ログイン後' do
      let(:user) { create(:user) }
      before do
        skip_login_line(user)
      end
      it '利用規約のリンクが表示される' do
        click_link '利用規約'
        expect(page).to have_content '利用規約'
      end
      it 'プライバシーポリシーのリンクが表示される' do
        click_link 'プライバシーポリシー'
        expect(page).to have_content 'プライバシーポリシー'
        expect(current_path).to eq privacy_policy_path
      end
    end
  end
end
