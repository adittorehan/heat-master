class Workspace < ApplicationRecord
  has_many :workspace_members, dependent: :destroy
  has_many :users, through: :workspace_members
  has_many :projects, dependent: :destroy

  validates :name, presence: true
end
