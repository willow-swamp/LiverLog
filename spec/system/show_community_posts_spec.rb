require 'rails_helper'

RSpec.describe 'コミュニティポストの詳細', type: :system do
  let!(:user) { create(:user) }
  let!(:community_post) { create(:community_post, user:) }

  describe 'コミュニティポストの詳細' do
    context 'ログインしていない場合' do
      it 'トップページにリダイレクトされる' do
        visit root_path
        click_link 'コミュニティ'
        click_link "community-post-#{community_post.id}"
      end
    end

    context 'ポストを作成したユーザーの場合' do
      before do
        skip_login_line(user)
        click_link 'コミュニティ'
        click_link "community-post-#{community_post.id}"
      end

      it '投稿したユーザー名が表示される' do
        expect(page).to have_content(community_post.user.username)
      end
      it 'ポストの詳細が表示される' do
        expect(page).to have_content(community_post.content)
        expect(page).to have_content(community_post.created_at.strftime('%m月%d日'))
      end
      it '編集リンクが表示される' do
        expect(page).to have_link('ポスト編集', visible: false)
      end
      it '削除リンクが表示される' do
        expect(page).to have_link('ポスト削除', visible: false)
      end
    end
  end

  context 'ポストを作成したユーザーでない場合' do
    let(:other_user) { create(:user) }
    let(:other_community_post) { create(:community_post, user:) }

    before do
      skip_login_line(other_user)
      click_link 'コミュニティ'
      click_link "community-post-#{community_post.id}"
    end

    it '投稿したユーザー名が表示される' do
      expect(page).to have_content(community_post.user.username)
    end
    it 'ポストの詳細が表示される' do
      expect(page).to have_content(community_post.content)
      expect(page).to have_content(community_post.created_at.strftime('%m月%d日'))
    end
    it '編集リンクが表示されない' do
      expect(page).not_to have_link('ポスト編集', visible: false)
    end
    it '削除リンクが表示されない' do
      expect(page).not_to have_link('ポスト削除', visible: false)
    end
  end

  context '招待ユーザーの場合' do
    let(:invited_user) { create(:user, :invitee) }
    let(:group) { create(:group, group_admin_id: user.id) }

    before do
      group.save_group_member(invited_user)
      skip_login_line(invited_user)
      click_link 'コミュニティ'
      click_link "community-post-#{community_post.id}"
    end

    it '投稿したユーザー名が表示される' do
      expect(page).to have_content(community_post.user.username)
    end
    it 'ポストの詳細が表示される' do
      expect(page).to have_content(community_post.content)
      expect(page).to have_content(community_post.created_at.strftime('%m月%d日'))
    end
    it '編集リンクが表示されない' do
      expect(page).not_to have_link('ポスト編集', visible: false)
    end
    it '削除リンクが表示されない' do
      expect(page).not_to have_link('ポスト削除', visible: false)
    end
  end
end
