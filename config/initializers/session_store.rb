# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_static_app_session',
  :secret      => 'f9450d0c5e48b93fea64d1cb06142903ba3dde10caf2f204c8e1f68cf043c5cce310272cf194e8ef2e1ba03c12088c9946a3bf2ece79a527f21f7bba1cb5df63'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
