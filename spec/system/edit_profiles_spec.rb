require 'rails_helper'

RSpec.describe 'ユーザープロフィールを更新する', type: :system do
  let(:user) { create(:user) }

  before do
    skip_login_line(user)
    click_link 'edit-profile'
  end

  describe 'プロフィールを更新する' do
    context 'ユーザー名を変更する場合' do
      it 'ユーザー名が変更される' do
        fill_in 'user_username', with: 'edit_username'
        click_button '登録'
        expect(page).to have_content 'プロフィールを更新しました'
        expect(current_path).to eq profile_path
        expect(page).to have_content 'edit_username'
      end
      it 'ユーザー名が空欄の場合は変更できない' do
        fill_in 'user_username', with: ''
        click_button '登録'
        expect(page).to have_content 'プロフィールの更新に失敗しました'
        expect(page).to have_content 'ユーザー名を入力してください'
        expect(current_path).to eq edit_profile_path
      end
    end
    context '休肝日を変更する場合' do
      it '休肝日が変更される' do
        7.times do |n|
          if n.even?
            check "user_non_drinking_days_#{n}"
          else
            uncheck "user_non_drinking_days_#{n}"
          end
        end
        click_button '登録'
        expect(page).to have_content 'プロフィールを更新しました'
        expect(current_path).to eq profile_path
        expect(page).to have_content '日曜日'
        expect(page).to have_content '火曜日'
        expect(page).to have_content '木曜日'
        expect(page).to have_content '土曜日'
      end
      it '休肝日が設定されていない場合は変更できない' do
        7.times do |n|
          uncheck "user_non_drinking_days_#{n}"
        end
        click_button '登録'
        expect(page).to have_content 'プロフィールの更新に失敗しました'
        expect(page).to have_content '休肝日を1日以上設定してください'
        expect(current_path).to eq edit_profile_path
      end
    end
    context 'ひとことを変更する場合' do
      it 'ひとことが変更される' do
        fill_in 'user_comment', with: 'edit_comment'
        click_button '登録'
        expect(page).to have_content 'プロフィールを更新しました'
        expect(current_path).to eq profile_path
        expect(page).to have_content 'edit_comment'
      end
    end
  end
end
