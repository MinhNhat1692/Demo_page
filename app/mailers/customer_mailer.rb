class CustomerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.customer_mailer.notice.subject
  #
  def notice email, token, number, name
    @token = token
    @number = number
    @name = name
    mail to: email, subject: "Phieu kham benh"
  end
end
