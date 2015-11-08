require 'net/ssh'

class PhoneWhisperer

  def initialize
    # set these in environment variables.
    Net::SSH.start("localhost", "pi", password: 'raspberry', port: 2224) do |ssh|
      ssh.open_channel do |ch|
        ch.send_data("raspberry\n")
      end
      ssh.exec! "sudo python /media/usb0/CMI-final/phone/remoteCommands.py AudioPlayer.playRingtone"
    end
  end
end

=begin
set the host, user and password in environment variables
where are the commands going to live?
we'll need to parse the commands when the come into the
phones_controller.

require 'rubygems'
require 'net/ssh'
Net::SSH.start("localhost", "pi", password: 'raspberry', port: 2224) do |ssh|
  ssh.open_channel do |ch|
    ch.send_data("raspberry\n")
  end
  ssh.exec! "sudo python /media/usb0/CMI-final/phone/remoteCommands.py AudioPlayer.playRingtone"
end

=end
