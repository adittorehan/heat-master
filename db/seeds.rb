User.destroy_all
WorkspaceMember.destroy_all
Workspace.destroy_all
Project.destroy_all
Survey.destroy_all

admin = User.create!(
  email: "admin@example.com", password: "password", first_name: "John", last_name: "Doe",
  confirmation_token: Clearance::Token.new, admin: true, status: :active
)

user = User.create!(
  email: "user@example.com", password: "password", first_name: "Jane", last_name: "Doe",
  confirmation_token: Clearance::Token.new, status: :active
)

john_workspace = Workspace.create!(name: "John's workspace", users: [admin])
jane_workspace = Workspace.create!(name: "Jane's workspace", users: [user])

Project.create!(name: "John's project", workspace_id: john_workspace.id)
Project.create!(name: "Jane's project", workspace_id: jane_workspace.id)
