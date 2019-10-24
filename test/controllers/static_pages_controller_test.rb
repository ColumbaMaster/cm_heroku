require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  test "should get root" do
    get root_path
    assert_response :success
    assert_select "title", "Master Pombo"
  end
  
  test "should get contato" do
    get faleconosco_path
    assert_response :success
    assert_select "title", "Master Pombo | Fale Conosco"
  end

end
