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
         :subject => "Willkommen bei Connectify.de",
         :body => "Hallo #{user.name.split[0]}! \n\nConnectify ist ein neues (April 2013) Portal, auf dem du Partner zum Sport machen finden kannst. Connectify ist mit Facebook verbunden, daher kannst du alle Connectify-User auch direkt auf Facebook besuchen und direkt anschreiben.\n\nIm Moment sind wir noch in der BETA-Phase, das heisst wir arbeiten mit Hochdruck an neuen Features und Partnern, um in Zukunft noch mehr Menschen fuer Connectify zu begeistern. Denn nur mit einer grossen Community kann Connectify funktionieren. Auch du kannst dabei helfen, indem du Connectify in deinem Freundeskreis bekannt machst.\n\nViel Spass!\nEuer Connectify-Team")
  end

end