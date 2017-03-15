require "gmail"
def main
  gmail = Gmail.connect(<email>,<password>)
  gmail.inbox.find(:unread).each do |email|
    #puts email.text_part ? email.text_part.body.decoded : nil
    #puts email.html_part ? email.html_part.body.decoded : nil
    email = gmail.compose do
      to <email>
      subject "You have got a new email!"
      body email.text_part ? email.text_part.body.decoded : nil
    end
    email.deliver!
  end
  gmail.logout
end

if __FILE__ == $PROGRAM_NAME
  main()
end
