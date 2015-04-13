class NewUserMailer < ActionMailer::Base

  def greeter_email(user)
    @user = user
    @url = ENV['PASSWORD_CONFIRMATION_URL']
    mail(to: @user.email, subject: 'Welcome to Call Me Ishmael')
  end
end