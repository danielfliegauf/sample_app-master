class RegistrationMailer < ActionMailer::Base

  default from: "register.connectify@gmail.com"

    self.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :port           => 587,
  :domain         => 'gmail.com',
  :authentication => "plain",
  :user_name      => 'register.connectify@gmail.com',
  :password       => 'ibvg2003',
  :enable_starttls_auto => true 
  }


def welcome_email(user)
    @user = user
    @url = "http://www.connectify.de/"

    mail(:to => user.email,
         :subject => "Willkommen bei Connectify",
         :body => "Hallo "+user.name+"! <br><br> Du hast dich erfolgreich bei Connectify eingeloggt und kannst ab sofort loslegen und dein erstes Micropost schreiben. Du weisst nicht was das ist? Dann lies dir die Einfuehrung durch! Es ist ganz einfach. <br><br> Viel Spass dabei!")
  end

end