require 'test_helper'

class TratamentosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tratamento = tratamentos(:one)
  end

  test "should get index" do
    log_in_as(@tratamento.usuario)
    get tratamentos_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@tratamento.usuario)
    get new_tratamento_url
    assert_response :success
  end

  test "should create tratamento" do
    log_in_as(@tratamento.usuario)
    assert_difference('Tratamento.count') do
      post tratamentos_url, params: { tratamento: { nome: @tratamento.nome, indicacao: @tratamento.indicacao, usuario_id: @tratamento.usuario_id } }
    end

    assert_redirected_to tratamentos_url
  end

  test "should show tratamento" do
    log_in_as(@tratamento.usuario)
    get tratamentos_url(@tratamento)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@tratamento.usuario)
    get edit_tratamento_url(@tratamento)
    assert_response :success
  end

  test "should update tratamento" do
    log_in_as(@tratamento.usuario)
    patch tratamento_url(@tratamento), params: { tratamento: { nome: @tratamento.nome, indicacao: @tratamento.indicacao, usuario_id: @tratamento.usuario_id } }
    assert_redirected_to tratamento_url(@tratamento)
  end

  test "should destroy tratamento" do
    log_in_as(@tratamento.usuario)
    assert_difference('Tratamento.count', -1) do
      delete tratamento_url(@tratamento)
    end

    assert_redirected_to tratamentos_url
  end
end
