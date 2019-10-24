require 'test_helper'

class UsuariosControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = usuarios(:aderman)
    @other_user = usuarios(:archer)
  end
  
  test "should get new" do
    get inscrever_path
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    get edit_usuario_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch usuario_path(@user), params: { user: { nome: @user.nome,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
   test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_usuario_path(@user)
    assert !flash.empty?
    assert_redirected_to usuario_path(@other_user)
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch usuario_path(@user), params: { usuario: { nome: @user.nome,
                                              email: @user.email } }
    assert !flash.empty?
    assert_redirected_to usuario_path(@other_user)
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch usuario_path(@other_user), params: {
                                    usuario: { password:          '555',
                                            password_confirmation: '565',
                                            admin: true } }
    assert_not @other_user.reload.admin?
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Usuario.count' do
      delete usuario_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'Usuario.count' do
      delete usuario_path(@user)
    end
    assert_redirected_to root_url
  end
end
