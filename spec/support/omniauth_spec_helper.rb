OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:facebook] = { 'provider' => 'facebook',
    'uid' => SecureRandom.hex,
   'info' => { 'email'      => Forgery(:internet).email_address,
               'first_name' => Forgery(:name).female_first_name,
               'last_name'  => Forgery(:name).last_name,
               'name'       => Forgery(:name).full_name,
               'nickname'   => Forgery(:lorem_ipsum).words }}
