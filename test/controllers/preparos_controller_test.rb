require 'test_helper'

class PreparosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @preparo = preparos(:one)
  end

  test "should get index" do
    get preparos_url
    assert_response :success
  end

  test "should get new" do
    get new_preparo_url
    assert_response :success
  end

  test "should create preparo" do
    assert_difference('Preparo.count') do
      post preparos_url, params: { preparo: { descricao: @preparo.descricao, nome: @preparo.nome, tipo_prova: @preparo.tipo_prova } }
    end

    assert_redirected_to preparo_url(Preparo.last)
  end

  test "should show preparo" do
    get preparo_url(@preparo)
    assert_response :success
  end

  test "should get edit" do
    get edit_preparo_url(@preparo)
    assert_response :success
  end

  test "should update preparo" do
    patch preparo_url(@preparo), params: { preparo: { descricao: @preparo.descricao, nome: @preparo.nome, tipo_prova: @preparo.tipo_prova } }
    assert_redirected_to preparo_url(@preparo)
  end

  test "should destroy preparo" do
    assert_difference('Preparo.count', -1) do
      delete preparo_url(@preparo)
    end

    assert_redirected_to preparos_url
  end
end
