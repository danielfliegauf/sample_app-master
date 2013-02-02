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
         :body => "Hallo "+user.name+"! Du hast dich erfolgreich bei Connectify eingeloggt und kannst ab sofort loslegen und dein erstes Micropost schreiben. Du weisst nicht was das ist? Dann lies dir die Einfuehrung durch! Es ist ganz einfach. <br><br> Viel Spass dabei!")
  end

  def comment_email(micropost, comment)
  	# @user = user
  	@micropost = micropost
  	mail(
      :to => micropost.user.email, 
      :subject => "Connectfiy - Your Post has a new comment",
      :body => "Hallo "+micropost.user.name+"!"+comment.body
    )

    micropost.user.followers.each do |user|
      mail(
        :to => user.email,
        :subject => "Connectfiy - Your abboniertes Post has a new comment",
        :body => "Hallo "+user.name+"!"+comment.body
      )
    end

    micropost.mindposts.each do |mindpost|
      mail(
        :to => mindpost.user.email,
        :subject => "Connectfiy - Your gemerktes Post has a new comment",
        :body => "Hallo "+mindpost.user.name+"!"+comment.body
      )
    end
  end
end
