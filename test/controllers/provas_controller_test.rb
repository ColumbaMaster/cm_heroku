require 'test_helper'

class ProvasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prova = provas(:one)
  end

  test "should get index" do
    log_in_as(@prova.usuario)
    get provas_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@prova.usuario)
    get new_prova_url
    assert_response :success
  end

  test "should create prova" do
    log_in_as(@prova.usuario)
    assert_difference('Prova.count') do
      post provas_url, params: { prova: { cidade: @prova.cidade, dtsolta: @prova.dtsolta, distancia: @prova.distancia, nome: @prova.nome, tipo: @prova.tipo, est_id: @prova.est_id, competicao_id: @prova.competicao_id, usuario_id: @prova.usuario.id }}
    end

    assert_redirected_to provas_url
  end

  test "should show prova" do
    log_in_as(@prova.usuario)
    get prova_url(@prova)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@prova.usuario)
    get edit_prova_url(@prova)
    assert_response :success
  end

  test "should update prova" do
    log_in_as(@prova.usuario)
    patch prova_url(@prova), params: { prova: { cidade: @prova.cidade, dtsolta: @prova.dtsolta, distancia: @prova.distancia, nome: @prova.nome, tipo: @prova.tipo } }
    assert_redirected_to prova_url(@prova)
  end

  test "should destroy prova" do
    log_in_as(@prova.usuario)
    assert_difference('Prova.count', -1) do
      delete prova_url(@prova)
    end

    assert_redirected_to provas_url
  end
end
