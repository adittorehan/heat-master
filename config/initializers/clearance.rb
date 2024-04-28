Clearance.configure do |config|
  config.mailer_sender = "admin@heatcheck.co"
  config.rotate_csrf_on_sign_in = true
  config.routes = false
end
