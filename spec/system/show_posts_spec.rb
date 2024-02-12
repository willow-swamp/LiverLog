require 'rails_helper'

RSpec.describe 'ポストが作成される', type: :system do
  let(:user) { create(:user) }
  let(:group) { create(:group, group_admin_id: user.id) }

  before do
    group.users << user
    skip_login_line(user)
  end

  describe 'ポスト一覧の表示' do
    before do
      click_link '休肝日・飲酒日を記録'
    end
    context '休肝日を記録する時' do
      it 'ポストが作成される' do
        choose 'no-drink-radio'
        click_button '登録'
        visit group_path(group)
        expect(page).to have_content "#{user.username}さんが休肝日を達成しました！！"
        expect(page).to have_content user.posts.last.drink_record.start_time.strftime('%F')
      end
    end
    context '飲酒日を記録する時' do
      it 'ポストが作成される' do
        choose 'drink-radio'
        fill_in 'drink_record[drink_volume]', with: 350
        fill_in 'drink_record[alcohol_percentage]', with: 5
        click_button '登録'
        visit group_path(group)
        expect(page).to have_content "#{user.username}さんがお酒を嗜みました🍺（#{Date.today.strftime('%m月%d日')}のアルコール摂取量：#{ApplicationController.helpers.alcohol_caluculate(
          user.posts.last.drink_record.drink_volume, user.posts.last.drink_record.alcohol_percentage
        )}g）"
        expect(page).to have_content user.posts.last.drink_record.start_time.strftime('%F')
      end
    end
  end

  describe 'ポスト詳細の表示' do
    let!(:drink_record) { create(:drink_record, :no_drink, user_id: user.id) }
    let!(:post) { create(:post, user_id: user.id, group_id: group.id, drink_record_id: drink_record.id) }

    before do
      click_link group.name
      click_link "post-#{post.id}"
    end

    context '休肝日の記録がされている時' do
      it 'ポスト詳細が表示される' do
        expect(page).to have_content post.content
        expect(page).to have_content post.drink_record.start_time.strftime('%m月%d日')
        expect(current_path).to eq group_post_path(group, post)
      end
    end

    let!(:drink_record) { create(:drink_record, user_id: user.id) }
    let!(:post) { create(:post, :drink, user_id: user.id, group_id: group.id, drink_record_id: drink_record.id) }

    context '飲酒日の記録がされている時' do
      it 'ポスト詳細が表示される' do
        expect(page).to have_content post.content
        expect(page).to have_content post.drink_record.start_time.strftime('%m月%d日')
      end
    end
  end
end
