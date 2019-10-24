require 'test_helper'

class MensagensControllerTest < ActionDispatch::IntegrationTest
  test "GET new" do
    get faleconosco_url

    assert_response :success

    assert_select 'form' do 
      assert_select 'input[type=text]'
      assert_select 'input[type=email]'
      assert_select 'textarea'
      assert_select 'input[type=submit]'
    end
  end
  
  test "POST create" do
    assert_difference 'ActionMailer::Base.deliveries.size', 1 do
      post create_message_url, params: {
        mensagem: {
          nome: 'cornholio',
          email: 'cornholio@example.org',
          body: 'hai'
        }
      }
    end

    assert_redirected_to faleconosco_path
    follow_redirect!
    assert_not flash.empty?

  end
  
  test "invalid POST create" do
    post create_message_url, params: {
      mensagem: { nome: '', email: '', body: '' }
    }
    assert_redirected_to faleconosco_path
    follow_redirect!
    assert_not flash.empty?
  end
  
end
