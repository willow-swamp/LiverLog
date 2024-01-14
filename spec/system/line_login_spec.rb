# require 'rails_helper'
# require 'webmock/rspec'

# RSpec.describe 'User Login with LINE via OauthsController', type: :system do
#   before do
#     # LINE認証のレスポンスを模倣
#     stub_request(:post, "https://api.line.me/oauth2/v2.1/token")
#       .to_return(
#         status: 200,
#         body: { access_token: "mock_access_token", token_type: "Bearer" }.to_json,
#         headers: { 'Content-Type' => 'application/json' }
#       )

#     # # その他必要なAPI呼び出しを模倣
#     # # 例: ユーザー情報取得API
#     stub_request(:get, "https://api.line.me/v2/profile")
#       .to_return(
#         status: 200,
#         body: { userId: "mock_user_id", displayName: "mock_user" }.to_json,
#         headers: { 'Content-Type' => 'application/json' }
#       )
#   end

#   it 'allows a user to log in with LINE' do
#     visit root_path
#     click_link 'line-login-btn'

#     # LINEログインの成功を模倣し、プロファイルページにリダイレクトされることを確認
#     expect(page).to have_current_path(first_login_path)
#     expect(page).to have_content 'ログイン成功'
#   end
