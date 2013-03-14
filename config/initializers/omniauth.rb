OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK'], ENV['FACEBOOK_KEY'],#, '147347702004703', '92909b6e4217f41cac177c809804424f',
  # {:scope => 'email, birthday', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}} 
  {:scope => 'email, user_groups', :display => "touch", :client_options => {:ssl => {:verify => false}}} #TODO:remove :client_options on production!!!
end