require "gmail"
require_relative ".mail.auth"
include Auth
def main
  puts "Welcome to my email resender app"
  if ($username == "")
    puts "Please, enter your email"
    $username = gets
  end
  if ($password == "")
    puts "Please, enter your password"
    $password = gets
  end
  puts "Do you want to save your credentials(yes/no)?"
  
  gmail = Gmail.connect($username, $password)
  gmail.inbox.find(:unread).each do |email|
    email = gmail.compose do
      to $email
      subject "You have got a new email!"
      body email.text_part ? email.text_part.body.decoded : nil
    end
    email.read!
    email.deliver!
  end
gmail.logout
end

if __FILE__ == $PROGRAM_NAME
  main()
end
