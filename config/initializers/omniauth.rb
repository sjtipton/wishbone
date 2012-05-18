Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "195212480559684", "2c214081035899030da49e6ec53160d1",
         { scope: 'email,
                   user_about_me,
                   user_interests,
                   user_likes,
                   user_location,
                   user_online_presence,
                   manage_pages,
                   publish_stream',
  client_options: { ssl: { ca_file: '/usr/lib/ssl/certs/ca-certificates.crt' } } }
end
