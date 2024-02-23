require 'rails_helper'

RSpec.describe 'コミュニティポストを編集する', type: :system do
  let(:user) { create(:user) }
  let(:community_post) { create(:community_post, user:) }

  before do
    skip_login_line(user)
    community_post
    click_link 'コミュニティ'
    click_link "community-post-#{community_post.id}"
  end

  describe 'コミュニティポストを編集する' do
    before do
      visit edit_community_post_path(community_post)
    end

    context 'フォームの入力値が正常な場合' do
      it '編集に成功する' do
        fill_in 'community_post[content]', with: '編集後のコンテンツ'
        click_button '投稿する'
        expect(page).to have_content 'ポストを更新しました'
        expect(page).to have_content '編集後のコンテンツ'
        expect(current_path).to eq community_post_path(community_post)
      end
    end

    context 'フォームの入力値が異常な場合' do
      it '編集に失敗する' do
        fill_in 'community_post[content]', with: ''
        click_button '投稿する'
        expect(page).to have_content 'ポストの更新に失敗しました'
        expect(page).to have_content '内容を入力してください'
        expect(current_path).to eq edit_community_post_path(community_post)
      end
    end

    context '他のユーザーのコミュニティポストを編集しようとした場合' do
      let(:other_user) { create(:user) }
      let(:other_community_post) { create(:community_post, user: other_user) }

      before do
        visit edit_community_post_path(other_community_post)
      end

      it '編集ページへのアクセスが失敗する' do
        expect(page).to have_content 'アクセス権限がありません'
        expect(current_path).to eq community_posts_path
      end
    end

    context '招待ユーザがコミュニティポストを編集しようとした場合' do
      let(:invited_user) { create(:user) }
      let(:group) { create(:group, group_admin_id: user.id) }

      before do
        group.save_group_member(invited_user)
        skip_login_line(invited_user)
        click_link 'コミュニティ'
      end

      it '編集リンクが表示されない' do
        expect(page).not_to have_link 'dropdown-btn'
      end

      it '編集ページへのアクセスが失敗する' do
        visit edit_community_post_path(community_post)
        expect(page).to have_content 'アクセス権限がありません'
        expect(current_path).to eq community_posts_path
      end
    end
  end
end
