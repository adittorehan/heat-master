class User < ApplicationRecord
  include Clearance::User

  has_many :workspace_memberships, dependent: :destroy, class_name: "WorkspaceMember"
  has_many :workspaces, through: :workspace_memberships

  validates :password, presence: true, if: -> { encrypted_password_changed? }

  scope :admin, -> { where(admin: true) }

  enum status: { inactive: 0, active: 1 }

  def full_name
    [first_name, last_name].compact.join(" ")
  end

  def webhook_response_data
    {
      id: id,
      status: status,
      email: email,
      first_name: first_name,
      last_name: last_name,
      created_at: created_at,
      updated_at: updated_at,
      admin: admin
    }
  end
end
