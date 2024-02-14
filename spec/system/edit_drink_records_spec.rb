require 'rails_helper'

RSpec.describe '休肝日&飲酒日記録を編集する', type: :system do
  let(:user) { create(:user) }
  let!(:drink_record) { create(:drink_record, user:) }

  before do
    skip_login_line(user)
  end

  describe '飲酒日の編集' do
    before do
      visit drink_record_path(drink_record)
      click_link "edit-drink-record-#{drink_record.id}"
    end

    context '記録日を変更する場合' do
      it '過去の日付に変更される' do
        fill_in '記録日', with: Date.today - 1
        click_button '登録'
        expect(page).to have_content '記録を更新しました'
        expect(current_path).to eq drink_record_path(drink_record)
      end
      it '未来の日付で変更に失敗する' do
        fill_in '記録日', with: Date.today + 1
        click_button '登録'
        expect(page).to have_content '記録の登録に失敗しました'
        expect(page).to have_content '記録日は未来の日付で登録できません'
        expect(current_path).to eq edit_drink_record_path(drink_record)
      end
    end
    context '記録タイプを変更する場合' do
      before do
        choose 'no-drink-radio'
      end
      it '休肝日に変更される' do
        click_button '登録'
        expect(page).to have_content '記録を更新しました'
        expect(current_path).to eq drink_record_path(drink_record)
      end
    end
    context '記録タイプを変更する場合' do
      let!(:other_drink_record) { create(:drink_record, :drink, user:) }
      before do
        visit drink_record_path(drink_record)
        click_link "edit-drink-record-#{drink_record.id}"
        choose 'no-drink-radio'
      end
      it '飲酒日の記録がある場合は休肝日に変更できない' do
        click_button '登録'
        expect(page).to have_content '記録の登録に失敗しました'
        expect(page).to have_content '記録日：同じ日に休肝日を複数記録することはできません'
        expect(current_path).to eq edit_drink_record_path(drink_record)
      end
    end
  end

  describe '休肝日の編集' do
    let!(:drink_record) { create(:drink_record, :no_drink, user:) }
    before do
      visit drink_record_path(drink_record)
      click_link '編集'
    end
    context '記録日を変更する場合' do
      it '過去の日付に変更される' do
        fill_in '記録日', with: Date.today - 1
        click_button '登録'
        expect(page).to have_content '記録を更新しました'
        expect(current_path).to eq drink_record_path(drink_record)
      end
      it '未来の日付で変更に失敗する' do
        fill_in '記録日', with: Date.today + 1
        click_button '登録'
        expect(page).to have_content '記録の登録に失敗しました'
        expect(page).to have_content '記録日は未来の日付で登録できません'
        expect(current_path).to eq edit_drink_record_path(drink_record)
      end
    end
    context '記録タイプを変更する場合' do
      before do
        choose 'drink-radio'
      end
      it '飲酒日に変更される' do
        click_button '登録'
        expect(page).to have_content '記録を更新しました'
        expect(current_path).to eq drink_record_path(drink_record)
      end
      it '飲酒日で詳細が記録される' do
        fill_in 'drink_record_drink_type', with: 'ビール'
        fill_in 'drink_volume', with: 500
        fill_in 'alcohol_percentage', with: 5
        fill_in 'price', with: 500
        click_button '登録'
        expect(page).to have_content '記録を更新しました'
        expect(current_path).to eq drink_record_path(drink_record)
      end
      it '飲酒量がマイナスの場合は記録できない' do
        fill_in 'drink_record_drink_type', with: 'ビール'
        fill_in 'drink_volume', with: -1
        fill_in 'alcohol_percentage', with: 5
        fill_in 'price', with: 500
        click_button '登録'
        expect(current_path).to eq edit_drink_record_path(drink_record)
      end
      it 'アルコール度数がマイナスの場合は記録できない' do
        fill_in 'drink_record_drink_type', with: 'ビール'
        fill_in 'drink_volume', with: 500
        fill_in 'alcohol_percentage', with: -1
        fill_in 'price', with: 500
        click_button '登録'
        expect(current_path).to eq edit_drink_record_path(drink_record)
      end
      it 'アルコール度数が100を超える場合は記録できない' do
        fill_in 'drink_record_drink_type', with: 'ビール'
        fill_in 'drink_volume', with: 500
        fill_in 'alcohol_percentage', with: 101
        fill_in 'price', with: 500
        click_button '登録'
        expect(current_path).to eq edit_drink_record_path(drink_record)
      end
      it '価格がマイナスの場合は記録できない' do
        fill_in 'drink_record_drink_type', with: 'ビール'
        fill_in 'drink_volume', with: 500
        fill_in 'alcohol_percentage', with: 5
        fill_in 'price', with: -1
        click_button '登録'
        expect(current_path).to eq edit_drink_record_path(drink_record)
      end
    end
  end

  describe '記録の削除' do
    before do
      visit drink_record_path(drink_record)
    end
    context '記録を削除する場合' do
      it '記録が削除される' do
        click_link '削除'
        expect(page.accept_confirm).to eq '削除しますか？'
        expect(page).to have_content '記録を削除しました'
        expect(current_path).to eq profile_path
      end
    end
  end
end
