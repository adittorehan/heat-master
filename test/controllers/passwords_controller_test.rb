require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  test "POST create should send password forgot email" do
    user = users(:john)
    user.update(confirmation_token: nil)

    assert_enqueued_emails 1 do
      post passwords_url, params: { password: { email: user.email } }
    end

    assert_not_nil user.reload.confirmation_token, "Token for user should be generated"

    assert_response :success
  end

  test "PATCH update should update password" do
    user = users(:john)

    user.update!(confirmation_token: "1234")

    patch user_password_url(user, token: "1234"), params: { password_reset: { password: "newpassword" } }

    assert_response :redirect
  end
end
