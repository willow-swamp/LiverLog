require "test_helper"

class Invitees::InvitationControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get invitees_invitation_new_url
    assert_response :success
  end
end
