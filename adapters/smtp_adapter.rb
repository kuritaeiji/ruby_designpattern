require('net/smtp')

class SmtpAdapter
  MailServerHost = 'localhost'
  MailServerPort = 25

  def send_message(message)
    from_address = message.from
    to_address = message.to

    email_text = ''

    Net::SMTP.start(MailServerHost, MailServerPort) do |smtp|
      smtp.send_message(email_text, from_address, to_address)
    end
  end
end