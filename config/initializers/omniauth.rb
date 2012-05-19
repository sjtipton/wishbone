Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "308692519214036", "190c700de3911ba2a543a9749a9a0ad8",
         { scope: 'email,
                   user_about_me,
                   user_interests,
                   user_likes,
                   user_location,
                   user_online_presence,
                   publish_stream',
  client_options: { ssl: { ca_file: '/usr/lib/ssl/certs/ca-certificates.crt' } } }
end
