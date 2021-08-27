class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  def send_approved_email(user)
    @user = user
    mail(:to => @user.email,
         :subject => "Account Status")
  end
end
