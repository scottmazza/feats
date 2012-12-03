class UserMailer < ActionMailer::Base
  default from: "feedback@featswithfriends.com"
  
  def welcome_email( user )
    @user = user
    mail( to: "#{user.name} <#{user.email}>", subject: "Welcome to Feats With Friends!" )
  end
end
