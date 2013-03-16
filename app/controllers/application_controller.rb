class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :prepare_for_mobile
  before_filter :set_locale
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  def current_user #DOPPETLT IN SESSIONSHELPER
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user
  include SessionsHelper

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS|iphone|android|bada|mobile|samsung|symbian/
    end
  end

  helper_method :mobile_device?

    def prepare_for_mobile
      session[:mobile_param] = params[:mobile] if params[:mobile]
      request.format = :mobile if mobile_device?
    end

    def facebook_logout
      split_token = session[:fb_token].split("|")
      fb_api_key = split_token[0]
      fb_session_key = split_token[1]
      redirect_to "https://www.facebook.com/logout.php?api_key=#{fb_api_key}&session_key=#{fb_session_key}&confirm=1&next=#{destroy_user_session_url}";
  end

# protected
#   def handle_fb_exception exception
#     if exception.fb_error_type.eql? 'OAuthException'
#       logger.debug "[OAuthException] Either the user's access token has expired, they've logged out of Facebook, deauthorized the app, or changed their password"
#       # oauth = Koala::Facebook::OAuth.new

#       # # If there is a code in the url, attempt to request a new access token with it
#       # if params.has_key? 'code'
#       #   code = params['code']
#       #   logger.debug "We have the following code in the url: #{code}"
#       #   logger.debug "Attempting to fetch a new access token..."
#       #   token_hash = oauth.get_access_token_info code
#       #   logger.debug "Obtained the following hash for the new access token:"
#       #   logger.debug token_hash.to_yaml
#       #   redirect_to root_path
#       # else # Since there is no code in the url, redirect the user to the Facebook auth page for the app
#       #   oauth_url = oauth.url_for_oauth_code :permissions => 'email'
#       #   logger.debug "No code was present; redirecting to the following url to obtain one: #{oauth_url}"
#         redirect_to "/auth/facebook"#oauth_url
#       end
#     # else
#     #   logger.debug "Since the error type is not an 'OAuthException', this is likely a bug in the Koala gem; reraising the exception..."
#     #   raise exception
#     # end
#   end
end
