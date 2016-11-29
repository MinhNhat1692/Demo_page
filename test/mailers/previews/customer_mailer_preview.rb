# Preview all emails at http://localhost:3000/rails/mailers/customer_mailer
class CustomerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/customer_mailer/notice
  def notice
    CustomerMailer.notice "ducck92gmail.com", "abcc", 1, "Tran Duc ck"
  end

end
