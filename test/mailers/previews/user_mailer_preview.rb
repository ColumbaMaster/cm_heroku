# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at https://master-pombo-adminmasterpombo.c9users.io/rails/mailers/user_mailer/account_activation
  def account_activation
    user = Usuario.first
    user.activation_token = Usuario.new_token
    UserMailer.account_activation(user)
  end

  # Preview this email at https://master-pombo-adminmasterpombo.c9users.io/rails/mailers/user_mailer/password_reset
  def password_reset
    user = Usuario.first
    user.reset_token = Usuario.new_token
    UserMailer.password_reset(user)
  end

end
