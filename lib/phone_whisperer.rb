class PhoneWhisperer

  def initialize(host,name,password)
    Net::SSH.start(host, name, password: 'raspberry', port: 2224) do |ssh|
      ssh.exec! "sudo python /media/usb0/CMI-final/phone/remoteCommands.py AudioPlayer.playContent 1"
    end
  end
end


=begin
set the host, user and password in environment variables
where are the commands going to live?

require 'rubygems'
require 'net/ssh'
Net::SSH.start("localhost", "pi", password: 'raspberry', port: 2224) do |ssh|
  ssh.exec! "sudo python /media/usb0/CMI-final/phone/remoteCommands.py AudioPlayer.playRingtone"
end

=end
