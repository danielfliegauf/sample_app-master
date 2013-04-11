class InterestsController < ApplicationController
	def new
	end

  def show

  end

	def create
    current_user.interests.each do |x|
      x.delete #delete nur database query, destroy sicherer weil noch before_destroy filter aufgerufen werden.
    end
    @homebase = current_user.homebase
    params[:interests].each do |key,value|
    
        current_user.interested!(key, @homebase)
      
    end
    # current_user.save!
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def edit
  end

  def update
  end

  def destroy
  	
  	redirect_to root_url
  end
end
