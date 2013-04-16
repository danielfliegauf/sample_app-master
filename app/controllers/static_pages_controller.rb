class StaticPagesController < ApplicationController
  def home
    @not_logged_in = params[:not_logged_in]
    #new users list 
    @users = User.all(:order => "created_at DESC", :limit => 10)
  	if signed_in?
      if (Time.parse(current_user.oauth_expires_at)+(60*60*2) <= Time.new() )
        store_location
          redirect_to "/auth/facebook" #TODO: remember redirect
        end
	  	@micropost = current_user.microposts.build
	  	@feed_items = current_user.feed.paginate(page: params[:page])
      @visitors = UserVisit.where(user_id: current_user.id).order("created_at DESC").limit(6)

      unless current_user.homebase

        @place 
         
      end
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

  def closeiframe
  end

  def news
  end

  def terms
  end

  def privacy
  end

  def search
      @microposts = Micropost.search(params[:place], params[:hobby])
      @interests = Interest.where("homebase = ? AND hobby = ?", params[:place], params[:hobby]) #homebase muss unique sein
    if params[:place]
      @lastsearch = params[:place]
      if params[:place].nil?
        @lastsearch = "select_city"
      end
      @lastsearch_value = params[:place]
    else
      @lastsearch = "select_city"
      @lastsearch_value = ""
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
