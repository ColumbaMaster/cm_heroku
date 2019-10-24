require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = usuarios(:michael)
    user.activation_token = Usuario.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Ativação da conta", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["naoresponda@columbamaster.com"], mail.from
    assert_match user.nome,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end
  
  test "password_reset" do
    user = usuarios(:michael)
    user.reset_token = Usuario.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Recuperação da senha", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["naoresponda@columbamaster.com"], mail.from
    #assert_match user.reset_token,        mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end

end
