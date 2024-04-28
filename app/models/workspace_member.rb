class WorkspaceMember < ApplicationRecord
  include ActionView::Helpers::UrlHelper

  attr_accessor :email, :inviter

  belongs_to :user
  belongs_to :workspace

  validates :workspace, uniqueness: { scope: :user_id }

  validate :user_with_email_exists
  validate :user_with_email_not_member_yet

  scope :creator, ->(user) { where(user_id: user.id, creator: true) }

  def user_with_email_exists
    return if email.nil? || User.exists?(email: email)

    errors.add(:email, "It looks like #{email} hasn’t signed up yet for HeatCheck. Click
      #{mail_to email, 'here', subject: 'Join me on HeatCheck', body: email_invite_message}
      to invite your colleague")
  end

  def email_invite_message
    "Hi,\n\nI would like to invite you to my workspace: "\
    "#{workspace.name}\n\nPlease create an account to join HeatCheck.\n\n"\
    "Kind regards,\n\n #{inviter&.full_name}"
  end

  def sign_up_url
    Rails.application.routes.url_helpers.sign_up_url(host: ENV["APP_HOST"])
  end

  def user_with_email_not_member_yet
    return unless email.present? && workspace.users.exists?(email: email)

    errors.add(:email, "This user is already part of this workspace.")
  end
end
