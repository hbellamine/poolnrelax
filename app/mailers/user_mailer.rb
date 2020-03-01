class UserMailer < ApplicationMailer
  default from: 'notifications@poolnrelax.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://www.poolnrelax.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
