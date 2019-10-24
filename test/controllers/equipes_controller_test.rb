require 'test_helper'

class EquipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @equipe = equipes(:one)
  end

  test "should get index" do
    log_in_as(@equipe.usuario)
    get equipes_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@equipe.usuario)
    get new_equipe_url
    assert_response :success
  end

  test "should create equipe" do
    log_in_as(@equipe.usuario)
    assert_difference('Equipe.count') do
      post equipes_url, params: { equipe: { nome: @equipe.nome, usuario_id: @equipe.usuario_id } }
    end

    #assert_redirected_to equipe_url(Equipe.last)
    assert_redirected_to equipes_url
  end

  test "should show equipe" do
    log_in_as(@equipe.usuario)
    get equipe_url(@equipe)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@equipe.usuario)
    get edit_equipe_url(@equipe)
    assert_response :success
  end

  test "should update equipe" do
    log_in_as(@equipe.usuario)
    patch equipe_url(@equipe), params: { equipe: { nome: @equipe.nome } }
    assert_redirected_to equipe_url(@equipe)
  end

  test "should destroy equipe" do
    log_in_as(@equipe.usuario)
    assert_difference('Equipe.count', -1) do
      delete equipe_url(@equipe)
    end

    assert_redirected_to equipes_url
  end
end
