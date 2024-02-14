require 'rails_helper'

RSpec.describe 'ポストに対するコメント機能', type: :system do
  let(:user) { create(:user) }
  let(:invitee) { create(:user, :invitee) }
  let(:group) { create(:group, group_admin_id: user.id) }
  let!(:drink_record) { create(:drink_record, :no_drink, user_id: user.id) }
  let!(:post) { create(:post, user_id: user.id, group_id: group.id, drink_record_id: drink_record.id) }

  before do
    group.users << user
    group.users << invitee
  end

  describe '一般ユーザーのコメントの投稿' do
    before do
      skip_login_line(user)
      click_link group.name
      click_link "post-#{post.id}"
    end
    context 'コメントの投稿に成功する時' do
      it 'コメントが投稿される' do
        fill_in 'post_comment[message]', with: 'コメント'
        click_button 'コメントする'
        expect(page).to have_content 'コメント'
        expect(page).to have_content user.username
        expect(page).to have_content 'コメントしました'
        expect(current_path).to eq group_post_path(group, post)
      end
    end

    context 'コメントの投稿に失敗する時' do
      it 'コメントが空の時' do
        fill_in 'post_comment[message]', with: ''
        click_button 'コメントする'
        expect(page).to have_content 'コメントに失敗しました'
        expect(current_path).to eq group_post_path(group, post)
      end
    end
  end

  describe 'コメントの削除' do
    let!(:post_comment) { create(:post_comment, user:, post:) }
    before do
      skip_login_line(user)
      click_link group.name
      click_link "post-#{post.id}"
    end
    context 'コメントの削除に成功する時' do
      it 'コメントが削除される' do
        expect(page).to have_content post_comment.message
        click_link "delete-comment-#{post_comment.id}"
        expect(page.accept_confirm).to eq '削除しますか？'
        expect(page).to have_no_content post_comment.message
      end
    end

    describe '招待ユーザーのコメントの投稿' do
      before do
        skip_login_invitee(invitee)
        click_link "post-#{post.id}"
      end
      context 'コメントの投稿に成功する時' do
        it 'コメントが投稿される' do
          fill_in 'post_comment[message]', with: 'コメント'
          click_button 'コメントする'
          expect(page).to have_content 'コメント'
          expect(page).to have_content invitee.username
          expect(page).to have_content 'コメントしました'
          expect(current_path).to eq group_post_path(group, post)
        end
      end

      context 'コメントの投稿に失敗する時' do
        it 'コメントが空の時' do
          fill_in 'post_comment[message]', with: ''
          click_button 'コメントする'
          expect(page).to have_content 'コメントに失敗しました'
          expect(current_path).to eq group_post_path(group, post)
        end
      end
    end

    describe '招待ユーザーのコメントの削除' do
      let!(:post_comment) { create(:post_comment, user: invitee, post:) }
      before do
        skip_login_invitee(invitee)
        click_link "post-#{post.id}"
      end
      context 'コメントの削除に成功する時' do
        it 'コメントが削除される' do
          expect(page).to have_content post_comment.message
          click_link "delete-comment-#{post_comment.id}"
          expect(page.accept_confirm).to eq '削除しますか？'
          expect(page).to have_no_content post_comment.message
        end
      end
    end
  end
end
