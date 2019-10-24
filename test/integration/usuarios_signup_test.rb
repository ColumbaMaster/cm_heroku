require 'test_helper'

class UsuariosSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "invalid signup information" do
    get inscrever_path
    assert_no_difference 'Usuario.count' do
      post usuarios_path , params: { usuario: { nome:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'usuarios/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "valid signup information with account activation basic" do
    get inscrever_path
    assert_difference 'Usuario.count', 1 do
      post usuarios_path, params: { usuario: { nome: "Example User",
                                              email: "user@example.com",
                                           password: "password",
                              password_confirmation: "password",
                                             lingua: "pt-BR"} }
    end
    user = assigns(:usuario)
    assert_redirected_to endereco_usuario_path(user)
    
    post salvar_endereco_usuario_path(user), params: { usuario: { logradouro: "Rua x", numero_logr: "123", 
                                                            bairro: "Bairro x", cidade: "Xxxx", est_id: 1, 
                                                            cep: "5525", tel1: "123456"} }
    
    assert_redirected_to editar_assinatura_usuario_path(user)
    
    assert_difference 'Plano.count', 1 do
      post assinar_usuario_path(user), params: { plano: "B" }
    end
    
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:usuario)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'usuarios/show'
    assert is_logged_in?
  end
  
  test "valid signup information with account activation paid" do
    get inscrever_path
    assert_difference 'Usuario.count', 1 do
      post usuarios_path, params: { usuario: { nome: "Example User",
                                              email: "user@example.com",
                                           password: "password",
                              password_confirmation: "password",
                                             lingua: "pt-BR"} }
    end
    user = assigns(:usuario)
    assert_redirected_to endereco_usuario_path(user)
    
    post salvar_endereco_usuario_path(user), params: { usuario: { logradouro: "Rua x", numero_logr: "123", 
                                                            bairro: "Bairro x", cidade: "Xxxx", est_id: 1, 
                                                            cep: "5525", tel1: "123456"} }
    
    assert_redirected_to editar_assinatura_usuario_path(user)
    
    assert_difference 'Plano.count', 1 do
      post assinar_usuario_path(user), params: { plano: "M", numero_cartao:"12345678901234", bandeira_cartao: "Visa", nome_cartao: "JOSE SOUZA SILVA", dtexpirado: 2.year.since.strftime("%m/%Y"), cvc_par: "123" }
    end
    
    user = assigns(:usuario)
    
    assert user.activated?
    log_in_as(user)
    assert is_logged_in?
    assert_redirected_to user
    
    # cancelar assinatura
    get detalhar_assinatura_usuario_path(user)
    post cancelar_assinatura_usuario_path(user)
    
    user = assigns(:usuario)
    assert_redirected_to user
    
    assert user.planos.last.dtcancelamento.present?
    
  end
end
