require 'test_helper'

class MessageMailerTest < ActionMailer::TestCase
  test "contact_me" do
    message = Mensagem.new nome: 'anna',
                          email: 'anna@example.org',
                          body: 'hello, how are you doing?'

    email = MessageMailer.contact_me(message)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal '[ColumbaMaster]Mensagem via Fale Conosco', email.subject
    assert_equal ['admin@columbamaster.com'], email.to
    assert_equal ['anna@example.org'], email.from
    assert_match /hello, how are you doing?/, email.body.encoded
  end

end
