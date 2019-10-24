require 'test_helper'

class MensagemTest < ActiveSupport::TestCase
  test 'responds to nome, email and body' do 
    msg = Mensagem.new

    assert msg.respond_to?(:nome),  'does not respond to :nome'
    assert msg.respond_to?(:email), 'does not respond to :email'
    assert msg.respond_to?(:body),  'does not respond to :body'
  end
  
  test 'should be valid when all attributes are set' do
    attrs = { 
      nome: 'stephen',
      email: 'stephen@example.org',
      body: 'kthnxbai'
    }

    msg = Mensagem.new attrs
    assert msg.valid?, 'should be valid'
  end

  test 'name, email and body are required by law' do
    msg = Mensagem.new

    refute msg.valid?, 'Blank Mesage should be invalid'

    assert_match 'não pode ficar em branco', msg.errors[:nome].to_s
    assert_match 'não pode ficar em branco', msg.errors[:email].to_s
    assert_match 'não pode ficar em branco', msg.errors[:body].to_s
  end
  
end