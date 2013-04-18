# Be sure to restart your server when you modify this file.
#prevent firefox white screen of death
SampleApp::Application.config.session_store :cookie_store, key: "_project_name_#{`pwd`.hash}"

# ActionController::CgiRequest::DEFAULT_SESSION_OPTIONS[:session_key] = "_project_name_#{`pwd`.hash}"
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# SampleApp::Application.config.session_store :active_record_store
