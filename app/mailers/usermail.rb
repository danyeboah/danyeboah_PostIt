class Usermail < ActionMailer::Base
  default from: "danyeboahdeveloper@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.usermail.password_reset.subject
  #
  def password_reset(user)
    @greeting = "Hi"
    @user = user

    mail to: @user.email, subject: "Reset your password"
  end
end
