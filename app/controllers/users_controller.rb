class UsersController < Clearance::UsersController
  skip_before_action :ensure_user_has_a_workspace
  skip_before_action :ensure_user_is_active

  def create
    @user = user_from_params
    @user.confirmation_token = Clearance::Token.new

    if @user.save
      sign_in(@user) do |status|
        if status.success?
          redirect_back_or url_after_create
          cookies.encrypted[:user_id] = @user.id
        else
          flash.now.notice = status.failure_message
          render template: "sessions/new", status: :unauthorized
        end
      end
    else
      render template: "users/new"
    end
  end

  private

  def user_params
    return {} if params[:user].blank?

    params[:user].permit(:email, :password, :first_name, :last_name)
  end
end
