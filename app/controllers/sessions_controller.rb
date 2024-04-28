class SessionsController < Clearance::SessionsController
  skip_before_action :ensure_user_has_a_workspace
  skip_before_action :ensure_user_is_active

  def create
    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        redirect_back_or url_after_create
        cookies.encrypted[:user_id] = @user.id
      else
        flash.now.notice = status.failure_message
        render template: "sessions/new", status: :unauthorized
      end
    end
  end
end
