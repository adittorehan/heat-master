require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "#forgot_password sends email to user with reset password link" do
    user = users(:john)
    user.forgot_password!

    email = UserMailer.forgot_password(user)

    assert_equal "Instructions to reset your password for HeatCheck", email.subject
    assert_includes email.body, "Change my password"
  end
end
