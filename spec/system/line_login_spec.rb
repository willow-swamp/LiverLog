require 'rails_helper'

RSpec.describe 'User Login with LINE via OauthsController', type: :system do
  before do
    # SorceryのOAuth認証プロセスを模倣する
    allow_any_instance_of(OauthsController).to receive(:login_at).and_return(mocked_auth_hash)
    allow_any_instance_of(OauthsController).to receive(:create_from).and_return(mocked_user)
  end

  it 'allows a user to log in with LINE' do
    visit root_path
    click_link 'LINEでログイン'

    # LINEログインの成功を模倣し、プロファイルページにリダイレクトされることを確認
    expect(page).to have_current_path(first_login_path)
    expect(page).to have_content 'ログイン成功'
  end

  def mocked_auth_hash
    # LINEの認証ハッシュを模倣する
    # 必要に応じてLINEからのレスポンスを模倣してください
    { provider: 'line', uid: '12345' }
  end

  def mocked_user
    # テスト用ユーザーを作成または取得
    create(:user)
  end
end
