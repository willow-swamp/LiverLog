require 'rails_helper'

RSpec.describe DrinkRecord, type: :model do
  let(:user) { create(:user) }

  describe 'バリデーション' do
    context 'バリデーションに通る' do
      it '休肝日記録の保存に成功する' do
        drink_record = build(:drink_record, user: user)
        expect(drink_record).to be_valid
        expect(drink_record.errors).to be_empty
      end
      it 'お酒の記録の保存に成功する' do
        drink_record = build(:drink_record, :no_drink, user: user)
        expect(drink_record).to be_valid
        expect(drink_record.errors).to be_empty
      end
    end

    context 'バリデーションに失敗する' do
      context '休肝日記録の保存の場合' do
        it '記録の種類がない' do
          drink_record = build(:drink_record, :no_drink, user: user, record_type: nil)
          expect(drink_record).to be_invalid
          expect(drink_record.errors[:record_type]).to include("を入力してください")
        end
        it '記録日が未来の日付になっている' do
          drink_record = build(:drink_record, :no_drink, user: user, start_time: DateTime.current + 1)
          expect(drink_record).to be_invalid
          expect(drink_record.errors[:start_time]).to include("未来の日付は使えません")
        end
        it '飲酒量が0mlとなる' do
          drink_record = build(:drink_record, :no_drink, user: user, drink_volume: 50)
          expect(drink_record).to be_invalid
          expect(drink_record.errors[:drink_volume]).to be_present
        end
        it 'アルコール度数が0%となる' do
          drink_reccord = build(:drink_record, :no_drink, user: user, alcohol_percentage: 5.0)
          expect(drink_reccord).to be_invalid
          expect(drink_reccord.errors[:alcohol_percentage]).to be_present
        end
      end

      context 'お酒の記録の保存の場合' do
        it '記録の種類がない' do
          drink_record = build(:drink_record, user: user, record_type: nil)
          expect(drink_record).to be_invalid
          expect(drink_record.errors[:record_type]).to include("を入力してください")
        end
        it '記録日が未来の日付になっている' do
          drink_record = build(:drink_record, user: user, start_time: DateTime.current + 1)
          expect(drink_record).to be_invalid
          expect(drink_record.errors[:start_time]).to include("未来の日付は使えません")
        end
        it '飲酒量が0ml以下となる' do
          drink_record = build(:drink_record, user: user, drink_volume: -1)
          expect(drink_record).to be_invalid
          expect(drink_record.errors[:drink_volume]).to include("は0以上の値にしてください")
        end
        it 'アルコール度数が0%未満となる' do
          drink_record = build(:drink_record, user: user, alcohol_percentage: -1.0)
          expect(drink_record).to be_invalid
          expect(drink_record.errors[:alcohol_percentage]).to be_present
        end
        it 'アルコール度数が100%以上となる' do
          drink_record = build(:drink_record, user: user, alcohol_percentage: 100.1)
          expect(drink_record).to be_invalid
          expect(drink_record.errors[:alcohol_percentage]).to be_present
        end
      end
    end
  end
end
