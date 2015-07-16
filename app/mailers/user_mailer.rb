class UserMailer < ActionMailer::Base

  def greeter_email(user)
    @user = user
    @url = ENV['PASSWORD_CONFIRMATION_URL'] + "?userId=#{@user.id}&userEmail=#{@user.email}"
    mail(to: @user.email, subject: 'Welcome to Call Me Ishmael')
  end

  def reset_email(user)
    @user = user
    @url = ENV['PASSWORD_RESET_URL'] + "?userId=#{@user.id}&userEmail=#{@user.email}"
    mail(to: @user.email, subject: 'Call Me Ishmael Password Reset')
  end
end