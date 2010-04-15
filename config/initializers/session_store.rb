# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dontplagiarizeus_session',
  :secret      => 'c32801e21244761b3928b5b0d23ff1f9a9b61ec83ed05122a38b93fe60d7afac21188b0b8f8d207cb7572c59d2de642bb6aa3b8e109c8a447c307be8246096d1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
