class Webhooks::ActivationController < Webhooks::BaseController
  def webhook
    begin
      payload = JSON.parse(request.body.read)
      @user = User.find_by(email: payload["email"])
      @action = payload["action"]

      if @user.present? && @action.in?(%w[activate deactivate])
        update_user
      else
        render(json: { error: "Invalid user or action" }, status: 400) && return
      end
    rescue JSON::ParserError
      render(json: { error: "Invalid user or action" }, status: 400) && return
    end
    render json: @user.webhook_response_data
  end

  private

  def update_user
    @user.update(status: :active) if @action == "activate"
    @user.update(status: :inactive) if @action == "deactivate"
  end
end
