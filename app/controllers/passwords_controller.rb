class PasswordsController < Clearance::PasswordsController
  skip_before_action :ensure_user_has_a_workspace
  skip_before_action :ensure_user_is_active

  def new
    @forgot_password = ForgotPassword.new

    render template: "passwords/new"
  end

  def edit
    if signed_in? && params[:new_user] == "1"
      redirect_to signed_in_root_path
      return
    end

    if params[:token]
      session[:password_reset_token] = params[:token]
      redirect_to url_for(new_user: params[:new_user])
    else
      @user = find_user_for_edit
      @new_user = params[:new_user] == "1"

      render template: "passwords/edit"
    end
  end

  def update
    @user = find_user_for_update

    if @user.update_password password_reset_params
      @user.update(status: :active) if params[:new_user] == "1"
      sign_in @user
      cookies.encrypted[:user_id] = @user.id if params[:new_user] == "1"
      redirect_to root_path
      session[:password_reset_token] = nil
    else
      flash[:notice] = @user.errors.full_messages_for(:password).join(", ")
      render template: "passwords/edit"
    end
  end

  def create
    @forgot_password = ForgotPassword.new(forgot_password_params)

    if @forgot_password.invalid?
      render template: "passwords/new"
      return
    elsif @user = find_user_for_create
      @user.forgot_password!
      UserMailer.forgot_password(@user).deliver_later
    end

    render template: "passwords/create"
  end

  private

  def forgot_password_params
    params.require(:password).permit(:email)
  end
end
