class UserMailer < ApplicationMailer
  def forgot_password(user)
    @user = user

    mail to: @user.email,
         subject: "Instructions to reset your password for HeatCheck"
  end

  def setup_password(user)
    @user = user

    mail to: @user.email,
         subject: "Instructions to set your password for HeatCheck"
  end
end
