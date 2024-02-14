require 'rails_helper'

RSpec.describe User, type: :model do
  describe '一般ユーザー' do
    describe 'バリデーションに通る' do
      it 'ユーザーの保存に成功する' do
        user = build(:user)
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
    end

    describe 'バリデーションに失敗する' do
      it '名前がない' do
        user = build(:user, username: nil)
        expect(user).to be_invalid
        expect(user.errors[:username]).to include('を入力してください')
      end
      it 'コメントが256文字以上になっている' do
        user = build(:user, comment: 'a' * 257)
        expect(user).to be_invalid
        expect(user.errors[:comment]).to include('は256文字以内で入力してください')
      end
      it '休肝日数がない' do
        user = build(:user, non_drinking_days: nil)
        expect(user).to be_invalid
        expect(user.errors[:non_drinking_days]).to include('を1日以上設定してください')
      end
      it '役割がない' do
        user = build(:user, role: nil)
        expect(user).to be_invalid
        expect(user.errors[:role]).to include('を入力してください')
      end
      it 'リマインダーの設定がない' do
        user = build(:user, reminder: nil)
        expect(user).to be_invalid
        expect(user.errors[:reminder]).to be_present
      end
      it '初回ログインの設定がない' do
        user = build(:user, first_login: nil)
        expect(user).to be_invalid
        expect(user.errors[:first_login]).to be_present
      end
    end
  end

  describe '管理者ユーザー' do
    describe 'バリデーションに通る' do
      it 'ユーザーの保存に成功する' do
        user = build(:user, :admin)
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
    end

    describe 'バリデーションに失敗する' do
      it '名前がない' do
        user = build(:user, :admin, username: nil)
        expect(user).to be_invalid
        expect(user.errors[:username]).to include('を入力してください')
      end
      it 'コメントが256文字以上になっている' do
        user = build(:user, :admin, comment: 'a' * 257)
        expect(user).to be_invalid
        expect(user.errors[:comment]).to include('は256文字以内で入力してください')
      end
      it '休肝日数がない' do
        user = build(:user, :admin, non_drinking_days: nil)
        expect(user).to be_invalid
        expect(user.errors[:non_drinking_days]).to include('を1日以上設定してください')
      end
      it '役割がない' do
        user = build(:user, :admin, role: nil)
        expect(user).to be_invalid
        expect(user.errors[:role]).to include('を入力してください')
      end
      it 'リマインダーの設定がない' do
        user = build(:user, :admin, reminder: nil)
        expect(user).to be_invalid
        expect(user.errors[:reminder]).to be_present
      end
      it '初回ログインの設定がない' do
        user = build(:user, :admin, first_login: nil)
        expect(user).to be_invalid
        expect(user.errors[:first_login]).to be_present
      end
    end
  end

  describe '招待ユーザー' do
    describe 'バリデーションに通る' do
      it 'ユーザーの保存に成功する' do
        user = build(:user, :invitee)
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
    end

    describe 'バリデーションに失敗する' do
      it '名前がない' do
        user = build(:user, :invitee, username: nil)
        expect(user).to be_invalid
        expect(user.errors[:username]).to include('を入力してください')
      end
      it 'コメントが256文字以上になっている' do
        user = build(:user, :invitee, comment: 'a' * 257)
        expect(user).to be_invalid
        expect(user.errors[:comment]).to include('は256文字以内で入力してください')
      end
      it '役割がない' do
        user = build(:user, :invitee, role: nil)
        expect(user).to be_invalid
        expect(user.errors[:role]).to include('を入力してください')
      end
      it 'リマインダーの設定がない' do
        user = build(:user, :invitee, reminder: nil)
        expect(user).to be_invalid
        expect(user.errors[:reminder]).to be_present
      end
      it '初回ログインの設定がない' do
        user = build(:user, :invitee, first_login: nil)
        expect(user).to be_invalid
        expect(user.errors[:first_login]).to be_present
      end
    end
  end
end
