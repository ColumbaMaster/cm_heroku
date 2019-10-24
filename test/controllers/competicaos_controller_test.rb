require 'test_helper'

class CompeticaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @competicao = competicaos(:one)
  end

  test "should get index" do
    log_in_as(@competicao.usuario)
    get competicaos_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@competicao.usuario)
    get new_competicao_url
    assert_response :success
  end

  test "should create competicao" do
    log_in_as(@competicao.usuario)
    assert_difference('Competicao.count') do
      post competicaos_url, params: { competicao: { ano: @competicao.ano, nome: @competicao.nome, usuario_id: @competicao.usuario.id, clb_id: 1, est_id: 1  } }
    end

    assert_redirected_to competicaos_url
  end

  test "should show competicao" do
    log_in_as(@competicao.usuario)
    get competicao_url(@competicao)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@competicao.usuario)
    get edit_competicao_url(@competicao)
    assert_response :success
  end

  test "should update competicao" do
    log_in_as(@competicao.usuario)
    patch competicao_url(@competicao), params: { competicao: { ano: @competicao.ano, nome: @competicao.nome } }
    assert_redirected_to competicao_url(@competicao)
  end

  test "should destroy competicao" do
    log_in_as(@competicao.usuario)
    assert_difference('Competicao.count', -1) do
      delete competicao_url(@competicao)
    end

    assert_redirected_to competicaos_url
  end
end
