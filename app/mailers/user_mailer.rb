class UserMailer < ActionMailer::Base
  default from: "comment.connectify@gmail.com"

  def welcome_email(user)
  	@user = user
  	@url = "http://www.connectify.de/"

  	mail(:to => user.email, :subject => "Welcome to CONNECTify :D")
  end

  def comment_email(micropost, comment)
  	# @user = user
  	@micropost = micropost
  	mail(
      :to => micropost.user.email, 
      :subject => "Connectfiy - Your Post has a new comment",
      :body => "Hello "+micropost.user.name+"!"+comment.body
    )
  end
end
