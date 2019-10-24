require 'test_helper'

class UsuariosEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = usuarios(:aderman)
  end


=begin
  test "unsuccessful edit" do
    get edit_usuario_path(@user)
    assert_template 'usuarios/edit'
    patch user_path(@user), params: { usuario: { nome:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'usuarios/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_usuario_path(@user)
    assert_template 'usuarios/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch usuario_path(@user), params: { usuario: { nome:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.nome
    assert_equal email, @user.email
  end


  test "successful edit with friendly forwarding" do
    get edit_usuario_path(@user)
    log_in_as(@user)
    #assert_redirected_to edit_usuario_path(@user)
    assert_template 'usuarios/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch usuario_path(@user), params: { usuario: { nome:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.nome
    assert_equal email, @user.email
  end
=end
end
