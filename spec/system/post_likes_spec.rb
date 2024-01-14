require 'rails_helper'

RSpec.describe "PostLikes", type: :system do
  let(:user) { create(:user) }
  let(:invitee) { create(:user) }
  let(:group) { create(:group, group_admin_id: user.id) }
  let(:drink_record) { create(:drink_record, user: user) }
  let(:post) { create(:post, user: user, group: group, drink_record: drink_record) }

  describe 'いいね機能' do
    before do
      group.users << user
      group.users << invitee
      drink_record
      post
      skip_login_invitee(invitee)
      click_link "post-#{post.id}"
    end

    context 'いいねに成功する時' do
      it 'いいねが投稿される' do
        click_link "button-like-#{post.id}"
        expect(page).to have_content '1'
      end
    end
    context "いいねを取り消す時" do
      let(:post_like) { create(:post_like, user: user, post: post) }
      it 'いいねが取り消される' do
        click_link "button-like-#{post.id}"
        expect(page).to have_content '0'
      end
    end
  end
end
