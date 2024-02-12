require 'rails_helper'

RSpec.describe 'コミュニティポストに対するコメント機能', type: :system do
  let!(:user) { create(:user) }
  let!(:community_post) { create(:community_post, user:) }
  let!(:community_post_comment) { create(:community_post_comment, user:, community_post:) }

  describe 'コメント投稿機能' do
    context 'ログインしている場合' do
      before do
        skip_login_line(user)
        click_link 'コミュニティ'
        click_link "community-post-#{community_post.id}"
      end

      it 'コメントが投稿できること' do
        fill_in 'community_post_comment[message]', with: 'テストコメント'
        click_button 'コメントする'
        expect(page).to have_content 'テストコメント'
        expect(page).to have_content user.username
        expect(current_path).to eq community_post_path(community_post)
      end

      it 'コメントが空の場合、投稿できないこと' do
        fill_in 'community_post_comment[message]', with: ''
        click_button 'コメントする'
        expect(current_path).to eq community_post_path(community_post)
      end

      it 'コメントが削除できること' do
        expect(page).to have_content community_post.content
        expect(page).to have_content community_post_comment.message
        click_link "delete-community-post-comment-#{community_post_comment.id}"
        expect(page).to have_no_content 'テストコメント'
      end
    end

    context '投稿ユーザーが異なる場合' do
      let(:other_user) { create(:user) }

      before do
        skip_login_line(other_user)
        click_link 'コミュニティ'
        click_link "community-post-#{community_post.id}"
      end

      it 'コメントが投稿できること' do
        fill_in 'community_post_comment[message]', with: 'テストコメント'
        click_button 'コメントする'
        expect(page).to have_content 'テストコメント'
        expect(page).to have_content other_user.username
        expect(current_path).to eq community_post_path(community_post)
      end

      it 'コメントが空の場合、投稿できないこと' do
        fill_in 'community_post_comment[message]', with: ''
        click_button 'コメントする'
        expect(current_path).to eq community_post_path(community_post)
      end

      it 'コメントが削除できないこと' do
        expect(page).to have_content community_post.content
        expect(page).to have_content community_post_comment.message
        expect(page).to have_no_link "delete-community-post-comment-#{community_post_comment.id}"
      end
    end

    context '招待ユーザーの場合' do
      let!(:invitee) { create(:user, :invitee) }
      let(:group) { create(:group, group_admin_id: user.id) }
      let!(:invitee_community_post_comment) { create(:community_post_comment, user: invitee, community_post:) }

      before do
        group.save_group_member(invitee)
        skip_login_invitee(invitee)
        click_link 'コミュニティ'
        click_link "community-post-#{community_post.id}"
      end

      it 'コメントが投稿できること' do
        fill_in 'community_post_comment[message]', with: 'テストコメント'
        click_button 'コメントする'
        expect(page).to have_content 'テストコメント'
        expect(page).to have_content invitee.username
        expect(current_path).to eq community_post_path(community_post)
      end

      it 'コメントが空の場合、投稿できないこと' do
        fill_in 'community_post_comment[message]', with: ''
        click_button 'コメントする'
        expect(current_path).to eq community_post_path(community_post)
      end

      it 'コメントが削除できること' do
        expect(page).to have_content community_post.content
        expect(page).to have_content invitee_community_post_comment.message
        click_link "delete-community-post-comment-#{invitee_community_post_comment.id}"
        expect(page).to have_no_content invitee_community_post_comment.message
      end
    end

    context 'ログインしていない場合' do
      it 'コメント投稿フォームがあるポスト詳細ページに遷移できない' do
        visit root_path
        click_link 'コミュニティ'
        click_link "community-post-#{community_post.id}"
        expect(page).to have_content 'ログインしてください'
      end
    end
  end
end
