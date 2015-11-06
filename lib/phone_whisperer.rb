require 'net/ssh'

class PhoneWhisperer

  def initialize
    # set these in environment variables.
    Net::SSH.start('localhost', 'ubuntu', password: 'raspberry', port: 2224) do |ssh|
      ssh.exec! "sudo python /media/usb0/CMI-final/phone/remoteCommands.py AudioPlayer.playRingtone"
    end
  end
end

=begin
set the host, user and password in environment variables
where are the commands going to live?

require 'rubygems'
require 'net/ssh'
Net::SSH.start("localhost", "pi", password: 'raspberry', port: 2224) do |ssh|
  ssh.exec! "sudo python /media/usb0/CMI-final/phone/remoteCommands.py NetSync.syncFiles"
end

=end
