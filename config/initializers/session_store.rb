# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_oang_session',
  :secret      => 'e9c01486d905c483e0576d0306d3926f00a14a42208f912a2bea1591bb07eaa82f90d10c31b23fb974c8e6a80e97ce5955ca67a310044d5ecc55e28048c2279d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
