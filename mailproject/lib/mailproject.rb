require "gmail"
require_relative ".mail.auth"
include Auth
def main
  gmail = Gmail.connect(Auth::USERNAME, Auth::PASSWORD)
  gmail.inbox.find(:unread).each do |email|
  email = gmail.compose do
    to Auth::EMAIL
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
