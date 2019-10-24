require 'test_helper'

class ClubesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @clube = clubes(:one)
  end

  test "should get index" do
    get clubes_url
    assert_response :success
  end

  test "should get new" do
    get new_clube_url
    assert_response :success
  end

  test "should create clube" do
    assert_difference('Clube.count') do
      post clubes_url, params: { clube: {  } }
    end

    assert_redirected_to clube_url(Clube.last)
  end

  test "should show clube" do
    get clube_url(@clube)
    assert_response :success
  end

  test "should get edit" do
    get edit_clube_url(@clube)
    assert_response :success
  end

  test "should update clube" do
    patch clube_url(@clube), params: { clube: {  } }
    assert_redirected_to clube_url(@clube)
  end

  test "should destroy clube" do
    assert_difference('Clube.count', -1) do
      delete clube_url(@clube)
    end

    assert_redirected_to clubes_url
  end
end
