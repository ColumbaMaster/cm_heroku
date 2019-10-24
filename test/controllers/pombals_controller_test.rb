require 'test_helper'

class PombalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pombal = pombals(:one)
  end

  test "should get index" do
    log_in_as(@pombal.usuario)
    get pombals_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@pombal.usuario)
    get new_pombal_url
    assert_response :success
  end

  test "should create pombal" do
    log_in_as(@pombal.usuario)
    assert_difference('Pombal.count') do
      post pombals_url, params: { pombal: { dtdesativ: @pombal.dtdesativ, nome: @pombal.nome, usuario_id: @pombal.usuario_id } }
    end
    assert_redirected_to pombals_url
  end

  test "should show pombal" do
    log_in_as(@pombal.usuario)
    get pombal_url(@pombal)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@pombal.usuario)
    get edit_pombal_url(@pombal)
    assert_response :success
  end

  test "should update pombal" do
    log_in_as(@pombal.usuario)
    patch pombal_url(@pombal), params: { pombal: { dtdesativ: @pombal.dtdesativ, nome: @pombal.nome, usuario_id: @pombal.usuario_id } }
    assert_redirected_to pombal_url(@pombal)
  end

  test "should destroy pombal" do
    log_in_as(@pombal.usuario)
    assert_difference('Pombal.count', -1) do
      delete pombal_url(@pombal)
    end

    assert_redirected_to pombals_url
  end
end
