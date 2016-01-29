OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :google_oauth2, '537827370882-ee1lctoopmm6khdi7vr3akep9ugll8if.apps.googleusercontent.com', '1yJGCL9_kKyheoXryuVG23Iu'#, {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'],display: "popup"
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'],display: "popup"
end