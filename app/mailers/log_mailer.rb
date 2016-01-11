class LogMailer < ActionMailer::Base

  def log_email(path)
    @path = path
    mail(to: 'smalley@ted.com', subject: 'Log File Delivered')
  end
end
