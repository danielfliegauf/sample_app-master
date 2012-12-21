class InvitationsController < ApplicationController
	before_filter :signed_in_user

	def create
		@user = User.find(params[:invitation][:invited_id])
		current_user.invite!(@user, 55)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	def destroy
		@user = Invitation.find(params[:id]).invited #(siehe relationship)
		current_user.uninvite!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end
end
