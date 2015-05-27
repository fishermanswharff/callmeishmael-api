class LogMailer < ActionMailer::Base

  def log_email(path)
    @path = path
    mail(to: 'fishermanswharff@mac.com', subject: 'Log File Delivered')
  end
end