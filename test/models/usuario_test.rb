require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase

  def setup
    @usuario = Usuario.new(nome: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "name should be present" do
    @usuario.nome = ""
    assert_not @usuario.valid?
  end

  test "email should be present" do
    @usuario.email = "     "
    assert_not @usuario.valid?
  end
  
  test "name should not be too long" do
    @usuario.nome = "a" * 51
    assert_not @usuario.valid?
  end

  test "email should not be too long" do
    @usuario.email = "a" * 244 + "@example.com"
    assert_not @usuario.valid?
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @usuario.email = invalid_address
      assert_not @usuario.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @usuario.dup
    duplicate_user.email = @usuario.email.upcase
    @usuario.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @usuario.email = mixed_case_email
    @usuario.save
    assert_equal mixed_case_email.downcase, @usuario.reload.email
  end
  
  test "password should be present (nonblank)" do
    @usuario.password = @usuario.password_confirmation = " " * 6
    assert_not @usuario.valid?
  end

  test "password should have a minimum length" do
    @usuario.password = @usuario.password_confirmation = "a" * 5
    assert_not @usuario.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @usuario.authenticated?(:remember, '')
  end
  
end
