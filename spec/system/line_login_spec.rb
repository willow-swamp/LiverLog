require 'rails_helper'

RSpec.describe 'User Login with LINE via OauthsController', type: :system do
  before do
    # LINE認証のレスポンスを模倣
    # WebMock.stub_request(:post, "https://api.line.me/oauth2/v2.1/token")
    #   .to_return(
    #     status: 200,
    #     body: { access_token: "mock_access_token", token_type: "Bearer" }.to_json,
    #     headers: { 'Content-Type' => 'application/json' }
    #   )

    # # その他必要なAPI呼び出しを模倣
    # # 例: ユーザー情報取得API
    # WebMock.stub_request(:get, "https://api.line.me/v2/profile")
    #   .to_return(
    #     status: 200,
    #     body: { userId: "mock_user_id", displayName: "mock_user" }.to_json,
    #     headers: { 'Content-Type' => 'application/json' }
    #   )
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
