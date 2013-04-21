class UserMailer < ActionMailer::Base
  default from: "comment.connectify@gmail.com"

      self.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :port           => 587,
  :domain         => 'gmail.com',
  :authentication => "plain",
  :user_name      => 'comment.connectify@gmail.com',
  :password       => 'ibvg2003',
  :enable_starttls_auto => true 
  }

  def welcome_email(user)
  	@user = user
  	@url = "http://www.connectify.de/"

  	mail(:to => user.email,
         :subject => "Willkommen bei Connectify",
         :body => "Hallo "+user.name+"! Du hast dich erfolgreich bei Connectify eingeloggt und kannst ab sofort loslegen und dein erste Activity erstellen. Du weisst nicht was das ist? Dann lies dir die Einfuehrung durch! Es ist ganz einfach. Viel Spass dabei!")
  end

  def comment_email(micropost, comment, writer)
  	# @user = user
  	@micropost = micropost
  	mail(
      :to => micropost.user.email, 
      :subject => "Connectify - Deine Activity hat einen neuen Kommentar",
      :body => "Hallo #{micropost.user.name.split[0]}!\n\n#{writer.name} hat einen neuen Kommentar hinterlassen:\n\n '#{comment.body}'\n\n Klicke hier um direkt hinzugelangen: http://connectify.de/microposts/#{micropost.id}\n\n Viel Spass weiterhin auf Connectify!"
    )

    # micropost.user.followers.each do |user|
    #   mail(
    #     :to => user.email,
    #     :subject => "Connectify - Eine Activity hat einen neuen Kommentar",
    #     :body => "Hallo "+user.name+"! "+comment.body
    #   )
    # end

    # micropost.mindposts.each do |mindpost|
    #   mail(
    #     :to => mindpost.user.email,
    #     :subject => "Connectify - Ein Micropost hat ein neuen Kommentar",
    #     :body => "Hallo "+mindpost.user.name+"! "+comment.body
    #   )
    # end
  end
end
