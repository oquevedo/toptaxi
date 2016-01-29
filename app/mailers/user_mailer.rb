class UserMailer < ActionMailer::Base

  $contact_email = "oscar@toptaxi.cl"
  default from: $contact_email

  # To unsubscribe from certain emails(must also be the :from of the message. 
    #EJ: mail(:to => @user.email, :from => "an_email@example.com", :subject => "Welcome"))
  # just add the line
  # @unsubscribe_from = 'an_email@example.com'

  $site_url = "http://toptaxi.herokuapp.com"

  def pre_welcome(pre_user)
    @user = pre_user
    @url  = $site_url

    mail(:to => @user.email, :subject => t('mails.welcome.title'))
  end
  
  def welcome(user, locale = :es)
    @locale = locale
    @user = user
    token = @user.tokens.first_or_create
    @token = token.value
    @url  = $site_url+"/activate/#{@token}"

    @unsubscribe_token = @user.tokens.first_or_create.value
    mail(:to => @user.email, :subject => t('mails.welcome.title'))
  end

  def feedback(user, email, locale = :es)
    @locale = locale
    @user = user.to_s
    @url  = $site_url
    mail(:to => email, :subject => t('mails.feedback.title'))
  end

  def contact_email(name, email, subject, content, locale = :es)
    @locale = locale
    @name = name
    @email = email
    @subject = subject
    @content = content
    @user = User.new
    
    @url  = $site_url

    mail(:to => $contact_email, :from => email, :subject => t('mails.contact.title'))
  end


  def recover_pass(user, token, locale = :es)
    @locale = locale
    @user = user
    @token = token
    @url  = $site_url+"/change_password/"+@token

    @unsubscribe_token = @user.tokens.first_or_create.value
    mail(:to => user.email, :subject => t('mails.recover_pass.title'))
  end



end
