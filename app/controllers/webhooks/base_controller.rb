class Webhooks::BaseController < ApplicationController
  skip_before_action :ensure_user_has_a_workspace
  skip_before_action :ensure_user_is_active
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token
  skip_authorize_resource

  before_action :verify_authentification_token

  def verify_authentification_token
    env_token = ENV["WEBHOOK_TOKEN"]
    request_token = request.headers["WEBHOOK-TOKEN"]

    return if env_token.present? && request_token.present? && env_token == request_token

    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
