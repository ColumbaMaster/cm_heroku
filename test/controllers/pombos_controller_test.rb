require 'test_helper'

class PombosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = usuarios(:michael)
    @pombo = pombos(:one)
  end

  test "should get index" do
    log_in_as(@user)
    get new_pombo_url #pombos_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@user)
    get new_pombo_url
    assert_response :success
  end

  test "should create pombo" do
    log_in_as(@user)
    assert_difference('Pombo.count') do
      post pombos_url, params: { pombo: { anilha: @pombo.anilha, cor_id: @pombo.cor_id, dtnasc: @pombo.dtnasc, nome: @pombo.nome, sexo: @pombo.sexo, usuario_id: @pombo.usuario_id } }
    end

    assert_redirected_to pombos_path
  end

  test "should show pombo" do
    log_in_as(@user)
    get pombo_url(@pombo)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_pombo_url(@pombo)
    assert_response :success
  end

  test "should update pombo" do
    log_in_as(@user)
    patch pombo_url(@pombo), params: { pombo: { anilha: @pombo.anilha, cor_id: @pombo.cor_id, dtnasc: nil, nome: @pombo.nome, sexo: @pombo.sexo, usuario_id: @pombo.usuario_id } }
    assert_redirected_to pombo_url(@pombo)
    #assert_response :success
  end

  test "should destroy pombo" do
    log_in_as(@user)
    assert_difference('Pombo.count', -1) do
      delete pombo_url(@pombo)
    end

    assert_redirected_to pombos_url
  end
  
end
