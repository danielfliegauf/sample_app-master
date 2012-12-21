class StaticPagesController < ApplicationController
  def home
    @not_logged_in = params[:not_logged_in]
  	if signed_in?
      if (Time.parse(current_user.oauth_expires_at)+(60*60*2) <= Time.new() )
          redirect_to "/auth/facebook" #TODO: remember redirect
        end
	  	@micropost = current_user.microposts.build
	  	@feed_items = current_user.feed.paginate(page: params[:page])
      # @city = Micropost.find(:distinct)
      # @city = Micropost.find_by_sql('SELECT DISTINCT place FROM microposts') #evtl unnötig ?!!yep
      end
  end

  def help
  end

  def about
  end

  def contact
  end

  def terms
  end

  def privacy
  end

  def search
      @microposts = Micropost.search(params[:place])
      if @microposts.length == 0
        flash[:error] = "NO MICROPOSTS"
      end
  end

  def write
    if signed_in?
      @micropost = current_user.microposts.build
    end
  end

  def result 
    @microposts = Micropost.search(params[:place]) #params[:hobby] anfangs disabled.
  end
end
