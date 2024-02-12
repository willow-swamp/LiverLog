require 'rails_helper'

RSpec.describe 'IndexCommunityPosts', type: :system do
  let(:user) { create(:user) }

  describe 'ログインしていない場合' do
    before do
      visit root_path
      click_link 'コミュニティ'
    end
    describe 'コミュニティポスト一覧を表示する' do
      it '「ポストする」ボタンが表示されない' do
        expect(page).to have_no_link 'ポストする'
      end
      context 'コミュニティポストが存在しない場合' do
        it 'メッセージが表示される' do
          expect(page).to have_content '投稿がありません'
        end
      end
      context 'コミュニティポストが存在する場合' do
        before do
          create_list(:community_post, 3, user:)
          visit community_posts_path
        end

        it 'コミュニティポストが表示される' do
          CommunityPost.take(3).each do |community_post|
            expect(page).to have_content community_post.content
            expect(page).to have_content community_post.user.username
          end
        end
      end
    end
  end

  describe '一般ユーザーでログインしている場合' do
    before do
      skip_login_line(user)
      click_link 'コミュニティ'
    end
    describe 'コミュニティポスト一覧を表示する' do
      it 'ユーザー名が表示される' do
        expect(page).to have_content user.username
        expect(page).to have_link 'マイページ'
      end
      it '「ポストする」ボタンが表示される' do
        expect(page).to have_link 'ポストする'
      end
      context 'コミュニティポストが存在しない場合' do
        it 'メッセージが表示される' do
          expect(page).to have_content '投稿がありません'
        end
      end
      context 'コミュニティポストが存在する場合' do
        before do
          create_list(:community_post, 3, user:)
          visit community_posts_path
        end

        it 'コミュニティポストが表示される' do
          CommunityPost.take(3).each do |community_post|
            expect(page).to have_content community_post.content
            expect(page).to have_content community_post.user.username
          end
        end
      end
    end
  end

  describe '招待ユーザーでログインしている場合' do
    let(:group) { create(:group, group_admin_id: user.id) }
    let(:invited_user) { create(:user, :invitee) }

    before do
      group.save_group_member(invited_user)
      skip_login_line(invited_user)
      click_link 'コミュニティ'
    end
    describe 'コミュニティポスト一覧を表示する' do
      it 'ユーザー名が表示される' do
        expect(page).to have_no_content invited_user.username
        expect(page).to have_no_link 'マイページ'
      end
      it '「ポストする」ボタンが表示されない' do
        expect(page).to have_no_link 'ポストする'
      end
      context 'コミュニティポストが存在しない場合' do
        it 'メッセージが表示される' do
          expect(page).to have_content '投稿がありません'
        end
      end
      context 'コミュニティポストが存在する場合' do
        before do
          create_list(:community_post, 3, user:)
          visit community_posts_path
        end

        it 'コミュニティポストが表示される' do
          CommunityPost.take(3).each do |community_post|
            expect(page).to have_content community_post.content
            expect(page).to have_content community_post.user.username
          end
        end
      end
    end
  end
end
