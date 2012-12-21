class MicropostsController < ApplicationController
	before_filter :signed_in_user
	before_filter :correct_user, only: :destroy

	def index
	end

	def show 
		@micropost = Micropost.find(params[:id])

		if (Time.parse(current_user.oauth_expires_at)+(60*60*2) <= Time.new() && current_user == @micropost.user)
        	redirect_to "/auth/facebook" #TODO: remember redirect
      	end
		
		@comment = @micropost.comments.all
		if (current_user == @micropost.user)
			@comment.each do |f|
				# f.read = true
				f.update_attributes(:read => true) 
			end
		end
		# app = FbGraph::Application.new('147347702004703', :secret => '92909b6e4217f41cac177c809804424f')
		# @ACCESS_TOKEN = app.get_access_token
		@ACCESS_TOKEN = current_user.oauth_token
		# 	@auth = request.env["omniauth.auth"]
		# 	@auth.slice(:provider, :uid)
		# 	update_attributes(:oauth_token => @auth["credentials"]["token"])
		# current_user.from_omniauth(env["omniauth.auth"])
		me = FbGraph::User.me(@ACCESS_TOKEN)
		# me.feed!(
		#   :message => 'Updating via FbGraph',
		#   :picture => 'https://graph.facebook.com/matake/picture',
		#   :link => 'https://github.com/nov/fb_graph',
		#   :name => 'FbGraph',
		#   :description => 'A Ruby wrapper for Facebook Graph API'
		# )
		

	end

	def update
		redirect_to root_path
	end

	def create 
		@micropost = current_user.microposts.build(params[:micropost])
		if (params[:micropost][:datetime] != "")
			@micropost.datetime = Time.parse(params[:micropost][:datetime])
			@micropost.weekday = @micropost.datetime.wday
		else
			@micropost.datetime = Time.now + (30*7*24*60*60) # Posting is valid for 30 weeks if theres no entry
			@micropost.weekday = "11" #11 code is for always
		end
		
		 if @micropost.country == " Deutschland"
		 	@micropost.country = " Germany"
		# 	(@micropost.country == " Germany" || @micropost.country == " Deutschland") &&
		 end
		if ( @micropost.save )
			flash[:success] = t('postsuccessfull')
			# Tell the UserMailer to send a welcome Email after save // DISABLED FOR HEROKU need to install addon sendgrid http://stackoverflow.com/questions/11446094/heroku-errnoeconnrefused-connection-refused-connect2
        		# UserMailer.welcome_email(@micropost.user).deliver
        	if params[:mobile] == 0
				redirect_to root_path
			else
				redirect_to current_user
			end
		else
			@feed_items = current_user.feed.paginate(page: params[:page])
			# if @micropost.country != " Germany"
			# 	flash[:error] = "We are sorry - your place must lie within Germany - yet... You chose:"+@micropost.country
			# else
				flash[:error] = "There was an Error... :( Please try again!"
			# end
			if params[:mobile] == 0
				render 'static_pages/home'
			else
				render 'static_pages/write'
			end
		end
	end

	def destroy
		@micropost.destroy
		redirect_to current_user
	end



	private



	def correct_user
		@micropost = current_user.microposts.find_by_id(params[:id])
	rescue
		redirect_to root_path
	end


end