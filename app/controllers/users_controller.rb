class UsersController < ApplicationController
  before_filter :signed_in_user
  # before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  # before_filter :admin_user, only: :destroy
	
  def show
    
		@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

    
    #nur für currentuser...
    if @user == current_user
      @interests = Array.new
      @user.interests.each do |i|
        @interests.push(i.hobby)
      end
      #frage nach aktuellem user ob in gruppe, aber nur wenn user.group == nil...
      fbuser = FbGraph::User.fetch(@user.uid, :access_token => @user.oauth_token)
      #Teste ob User in FB Gruppe
      group = fbuser.groups
      @test = group

      # @group_attribute = false
      # current_user.group = false
      group.each do |x|
        if x.name == 'Connectify'
          @group_attribute = true
          current_user.group = true
          break
        else
          @group_attribute = false
          current_user.group = false
        end
      end

      current_user.save

    else
      begin
      #user nicht current_user
      @exist = UserVisit.where(user_id: @user.id).where(visitor_id: current_user.id).first
      if @exist.nil?
      @user.user_visits.build(:visitor_id => current_user.id).save!
      end


      #user oauth abgelaufen
      if ((Time.now <=> (Time.parse(@user.oauth_expires_at)+(60*60))) == 1)
        #do something
        

      else #user oauth noch nicht abgelaufen
      #Zuerst schauen ob CurrentUser in Gruppe
        if current_user.group == false || current_user.group == nil
            #frage nach aktuellem user ob in gruppe, aber nur wenn user.group == nil...
          fbcurrent_user = FbGraph::User.fetch(current_user.uid, :access_token => current_user.oauth_token)
          #Teste ob User in FB Gruppe
          group = fbcurrent_user.groups

          group.each do |x|
            if x.name == 'Connectify'
              current_user.group = true
              break
            else
              current_user.group = false
            end
          end

          if fbcurrent_user.groups.empty?
          current_user.group = false
          
          end
          current_user.save
        end
      
        fbuser = FbGraph::User.fetch(@user.uid, :access_token => @user.oauth_token)
        
        fbuser.groups.each do |x|
          if x.name == 'Connectify'
            @user.group = true
            break
          else
            @user.group = false
          end
        end

        if fbuser.groups.empty?
           @user.group = false
        end
        @user.save


      end #end user oauth abgelaufen

      rescue FbGraph::Unauthorized => e
        case e.message
        when /Duplicate status message/
          
          # handle dup code
        when /Error validating access token/
                 
          # handle bad credentials
        else
          raise e
        end
       end #end rescue
    end # end current oder other user



  end #end class

  def new #deprecated
  	@user = User.new
  end

  def create #deprecated!
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      redirect_to @user
      flash[:success] = "Welcome to Connectify!"
  	else
  		render 'new'
  	end
  end

  def edit #deprecated!
    #@user = User.find(params[:id]) #GIBTS SCHON IN correct_user before_filter!!
    

  end

  def update
    #@user = User.find(params[:id]) #GIBTS SCHON IN correct_user before_filter!!
    # if @user.update_attributes(params[:user])
    #   flash[:success] = "Profile updated"
    #   sign_in @user
    #   redirect_to @user
    # else
    #   render 'edit'
    # end
    current_user.homebase = params[:user][:homebase] #TODO: brauchen die translation in der db!
    current_user.save!
    current_user.interests.each do |i|
      i.homebase = params[:user][:homebase]
      i.save!
    end
    respond_to do |format|
      format.html {
        redirect_to user_path}
      format.js
    end
  end

  def index
    @users = User.paginate(page: params[:page]).searchplace(params[:place])
    @city = Micropost.find_by_sql('SELECT DISTINCT place FROM microposts')
      @place = Array.new(@city.length)

      for city in @city
        unless city == nil || city == ""
          @place.push(city.place)
          @place.shift
        end 
      end
  end

  def destroy
    # super
    # session[:user_id] = nil
    # reset_session
    sleep 1
    
    if token = current_user.oauth_token
       reset_session
      sleep 3
      User.find(params[:id]).destroy
      #redirect_to "https://www.facebook.com/logout.php?access_token=" + token + "&next=http%3A%2F%2Flocalhost:3000"
       redirect_to "https://www.facebook.com/logout.php?access_token=" + token + "&next=https%3A%2F%2Fconnectify.herokuapp.com%2F"
    else
    flash[:success] = "User destroyed."
    redirect_to root_path
  end
  end

def following
  @title = "Following"
  @user = User.find(params[:id])
  @users = @user.followed_users.paginate(page: params[:page])
  render 'show_follow'
end

def followers
  @title = "Followers"
  @user = User.find(params[:id])
  @users = @user.followers.paginate(page: params[:page])
  render 'show_follow'
end

 private

    

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

 

end
