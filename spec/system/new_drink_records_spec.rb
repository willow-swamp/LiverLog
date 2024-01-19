require 'rails_helper'

RSpec.describe '休肝日&飲酒日を記録する', type: :system do
  let(:user) { create(:user) }

  before do
    skip_login_line(user)
    click_link '休肝日・飲酒日を記録'
  end

  describe '休肝日を記録する' do
    before do
      choose 'no-drink-radio'
    end
    context '記録日が今日の場合' do
      it '休肝日が記録される' do
        click_button '登録'
        expect(page).to have_content '記録を登録しました'
        expect(current_path).to eq "/drink_records/#{DrinkRecord.last.id}"
      end
      it '同じ日に複数回記録できない' do
        click_button '登録'
        visit profile_path
        click_link '休肝日・飲酒日を記録'
        choose 'no-drink-radio'
        click_button '登録'
        expect(page).to have_content '記録の登録に失敗しました'
        expect(current_path).to eq new_drink_record_path
      end
    end
    context '記録日が今日以外の場合' do
      it '過去の休肝日が記録される' do
        fill_in '記録日', with: Date.today - 1
        click_button '登録'
        expect(page).to have_content '記録を登録しました'
        expect(current_path).to eq "/drink_records/#{DrinkRecord.last.id}"
      end
      it '未来の日付で記録ができない' do
        fill_in '記録日', with: Date.today + 1
        click_button '登録'
        expect(page).to have_content '記録の登録に失敗しました'
        expect(current_path).to eq new_drink_record_path
      end
    end
    context '休肝日の詳細を入力する場合' do
      it '休肝日が記録できない' do
        fill_in 'drink_record_drink_type', with: 'ビール'
        fill_in 'drink_volume', with: 500
        fill_in 'alcohol_percentage', with: 5
        fill_in 'price', with: 500
        click_button '登録'
        expect(page).to have_content '記録の登録に失敗しました'
        expect(current_path).to eq new_drink_record_path
      end
    end
  end

  describe '飲酒日を記録する' do
    before do
      choose 'drink-radio'
    end
    context '記録日のみを入力した場合' do
      it '当日に飲酒日が記録される' do
        click_button '登録'
        expect(page).to have_content '記録を登録しました'
        expect(current_path).to eq "/drink_records/#{DrinkRecord.last.id}"
      end
      it '過去の日付に飲酒日が記録される' do
        fill_in '記録日', with: Date.today - 1
        click_button '登録'
        expect(page).to have_content '記録を登録しました'
        expect(current_path).to eq "/drink_records/#{DrinkRecord.last.id}"
      end
      it '未来の日付で記録ができない' do
        fill_in '記録日', with: Date.today + 1
        click_button '登録'
        expect(page).to have_content '記録の登録に失敗しました'
        expect(current_path).to eq new_drink_record_path
      end
    end
    context '飲酒記録の詳細を入力する場合' do
      it '飲酒記録が記録される' do
        fill_in 'drink_record_drink_type', with: 'ビール'
        fill_in 'drink_volume', with: 500
        fill_in 'alcohol_percentage', with: 5
        fill_in 'price', with: 500
        click_button '登録'
        expect(page).to have_content '記録を登録しました'
        expect(current_path).to eq "/drink_records/#{DrinkRecord.last.id}"
      end
      it '飲酒量がマイナスの場合は記録できない' do
        fill_in 'drink_record_drink_type', with: 'ビール'
        fill_in 'drink_volume', with: -1
        fill_in 'alcohol_percentage', with: 5
        fill_in 'price', with: 500
        click_button '登録'
        expect(current_path).to eq new_drink_record_path
      end
      it 'アルコール度数がマイナスの場合は記録できない' do
        fill_in 'drink_record_drink_type', with: 'ビール'
        fill_in 'drink_volume', with: 500
        fill_in 'alcohol_percentage', with: -1
        fill_in 'price', with: 500
        click_button '登録'
        expect(current_path).to eq new_drink_record_path
      end
      it 'アルコール度数が100を超える場合は記録できない' do
        fill_in 'drink_record_drink_type', with: 'ビール'
        fill_in 'drink_volume', with: 500
        fill_in 'alcohol_percentage', with: 101
        fill_in 'price', with: 500
        click_button '登録'
        expect(current_path).to eq new_drink_record_path
      end
      it '価格がマイナスの場合は記録できない' do
        fill_in 'drink_record_drink_type', with: 'ビール'
        fill_in 'drink_volume', with: 500
        fill_in 'alcohol_percentage', with: 5
        fill_in 'price', with: -1
        click_button '登録'
        expect(current_path).to eq new_drink_record_path
      end
    end
  end
end
