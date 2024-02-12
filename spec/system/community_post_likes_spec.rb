require 'rails_helper'

RSpec.describe 'コミュニティポストに対するいいね機能', type: :system do
  let(:user) { create(:user) }
  let!(:community_post) { create(:community_post, user:) }

  describe 'いいね機能' do
    context 'ログインしている場合' do
      before do
        skip_login_line(user)
        click_link 'コミュニティ'
        click_link "community-post-#{community_post.id}"
      end

      it '自分の投稿に対していいねができ、いいねを取り消すことができる' do
        click_link "button-like-#{community_post.id}"
        expect(page).to have_content '1'
        click_link "button-like-#{community_post.id}"
        expect(page).to have_content '0'
      end
    end

    context '投稿ユーザーとは異なるユーザーでログインしている場合' do
      let(:other_user) { create(:user) }
      before do
        skip_login_line(other_user)
        click_link 'コミュニティ'
        click_link "community-post-#{community_post.id}"
      end

      it '他のユーザーの投稿に対していいねができ、いいねを取り消すことができる' do
        click_link "button-like-#{community_post.id}"
        expect(page).to have_content '1'
        click_link "button-like-#{community_post.id}"
        expect(page).to have_content '0'
      end
    end

    context 'ログインしていない場合' do
      it 'いいねボタンがあるポスト詳細ページが表示されない' do
        visit root_path
        click_link 'コミュニティ'
        click_link "community-post-#{community_post.id}"
        expect(page).to have_content 'ログインしてください'
      end
    end
  end
end
