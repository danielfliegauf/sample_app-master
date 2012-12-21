class MindpostsController < ApplicationController
	before_filter :signed_in_user

	def create
		@micropost = Micropost.find(params[:mindpost][:micropost_id])
		@mindpost = @micropost.mindposts.build
		@mindpost.user = current_user
		@mindpost.save
		respond_to do |format|
			format.html { redirect_to @micropost }
			format.js
		end
				
	end

	def destroy
		@mindpost = Mindpost.find(params[:id])
		@micropost = Micropost.find_by_id(@mindpost.micropost_id)
		@mindpost.destroy
		respond_to do |format|
			format.html { redirect_to micropost_path(@micropost) }
			format.js
		end
	end


end
