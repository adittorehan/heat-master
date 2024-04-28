class Webhooks::SignupController < Webhooks::BaseController
  def webhook # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    begin
      payload = JSON.parse(request.body.read)
      @email = payload["email"]
      @first_name = payload["first_name"]
      @last_name = payload["last_name"]
      existing_user = User.find_by(email: payload["email"])

      if existing_user.present?
        render(json: { error: "User already exist" }, status: 400) && return
      elsif @email.present?
        user = new_user
        if user.save
          UserMailer.setup_password(user).deliver_later
        else
          render(json: { error: "Can't save the user" }, status: 400) && return
        end
      end
    rescue JSON::ParserError
      render(json: { error: "Invalid data" }, status: 400) && return
    end
    render json: user.webhook_response_data
  end

  private

  def new_user
    User.new(
      email: @email,
      first_name: @first_name,
      last_name: @last_name,
      password: SecureRandom.hex,
      confirmation_token: Clearance::Token.new
    )
  end
end
