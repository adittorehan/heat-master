require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "POST create should add new user" do
    assert_difference "User.count", 1 do
      post users_url(params: {
        user: {
          email: "jack@example.com",
          password: "password",
          first_name: "Jack",
          last_name: "Jones"
        }
      })

    end

    user = User.last
    assert_equal user.email, "jack@example.com"
    assert_equal user.first_name, "Jack"
    assert_equal user.last_name, "Jones"

    assert_response :redirect
  end

  test "POST create should login a user and set the user_id cookie" do
    assert_difference "User.count", 1 do
      post users_url(params: {
        user: {
          email: "jack@example.com",
          password: "password",
          first_name: "Jack",
          last_name: "Jones"
        }
      })

    end

    assert response.cookies["user_id"]
    assert_redirected_to root_url
  end

  test "POST create with invalid data should render" do
    assert_no_difference "User.count" do
      post users_url(params: {
        user: {
          email: "jack@example.com",
          password: "",
          first_name: "",
          last_name: ""
        }
      })
    end

    assert_response :success
  end
end
