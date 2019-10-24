class MessageMailerPreview < ActionMailer::Preview

  # Preview this email at
  # https://master-pombo-adminmasterpombo.c9users.io/rails/mailers/message_mailer/contact_me
  def contact_me 
    message = Mensagem.new nome: 'marflar', 
                          email: 'marflar@example.org',
                          body: 'This is the body of the email',
                          telefone: 55231255

    MessageMailer.contact_me message
  end

end
