require "gmail"
require "io/console"
require_relative ".mail.auth"
include Auth
def main
  puts "Welcome to my email resender app"
  if ($username == nil)
    puts "Please, enter your main email"
    $user = STDIN.noecho(&:gets).chomp
  end
  if ($password == nil)
    puts "Please, enter your password"
    $pass = STDIN.noecho(&:gets).chomp
  end
  if ($mailbox == nil)
    puts "Please, enter your additional email "
    $mail = STDIN.noecho(&:gets).chomp
  end

  puts "Do you want to save your credentials(yes/no)?"
  @answer = gets.chomp
  if (@answer == "yes")
    puts "okay"
    target = open(".mail.auth.rb", "w")
    target.write("module Auth\n  $username = '#{$user}'\n  $password = '#{$pass}'\n  $mailbox = '#{$mail}'\nend" )
  elsif (@answer == "no")
    puts "not okay"
  end

  gmail = Gmail.connect($username, $password)
  puts "Connecting to the server"
  gmail.inbox.find(:unread).each do |email|
    message = gmail.compose do
      to $mailbox
      subject "You have got a new email!"
      body email.text_part ? email.text_part.body.decoded : nil
      charset = "UTF-8"
    end
    message.deliver!
    puts "Message delivered!"
#    email.read!
  end
  gmail.logout
end

if __FILE__ == $PROGRAM_NAME
  main()
end
