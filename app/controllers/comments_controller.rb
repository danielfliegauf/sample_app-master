class CommentsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :edit, :destroy]

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(params[:comment])
    @comment.user = current_user
    @comment.read = false
    if @comment.save
      #sende Mail bei neuem Comment an Microposterteller
      UserMailer.comment_email(@micropost, @comment).deliver
    	flash[:success] = "Comment was created successfully!"
    else
    	flash[:error] = "There was an Error!"
    end
    redirect_to micropost_path(@micropost)
  end

  def destroy
  	@micropost = Micropost.find(params[:micropost_id])
  	@comment = @micropost.comments.find(params[:id])
  	@comment.destroy
  	redirect_to micropost_path(@micropost)
  end

  def show
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find(params[:id])
  end


  def edit
  	@micropost = Micropost.find(params[:micropost_id])
  	@comment = @micropost.comments.find(params[:id])
  end

  def update
  	@comment = Comment.find(params[:id])
    if @comment.update_attribute(:body, params[:comment][:body])
  	# if @comment.update_attributes(params[:comment])
  		flash[:success] = "Comment was sucessfully edited."
    else
      flash[:error] = "An Error occurred!"
  	end
  	redirect_to :controller => 'microposts', :action => 'show', :id => @comment.micropost_id
  end


end

