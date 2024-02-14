require 'rails_helper'

RSpec.describe 'コミュニティポストを新しく投稿する', type: :system do
  let(:user) { create(:user) }

  describe 'ログインせずに新しいコミュニティポストを投稿しようとした場合' do
    it 'ログインページへリダイレクトされる' do
      visit new_community_post_path
      expect(page).to have_content 'ログインしてください'
      expect(current_path).to eq root_path
    end
  end

  describe 'ログインして新しいコミュニティポストを投稿する' do
    before do
      skip_login_line(user)
      click_link 'コミュニティ'
      click_link 'ポストする'
    end

    context '内容を入力した場合' do
      it 'ポストが投稿される' do
        fill_in '内容', with: '新しいコミュニティポスト'
        click_button '登録'
        expect(page).to have_content 'ポストを投稿しました'
        expect(current_path).to eq community_posts_path
        expect(page).to have_content '新しいコミュニティポスト'
      end
    end
    context '内容を入力しなかった場合' do
      it 'ポストが投稿されない' do
        click_button '登録'
        expect(page).to have_content 'ポストの投稿に失敗しました'
        expect(page).to have_content '内容を入力してください'
        expect(current_path).to eq new_community_post_path
      end
    end
    context '内容に指定文字数を超えた場合' do
      it 'ポストが投稿されない' do
        fill_in '内容', with: 'a' * 1001
        click_button '登録'
        expect(page).to have_content 'ポストの投稿に失敗しました'
        expect(current_path).to eq new_community_post_path
      end
    end
  end
end
