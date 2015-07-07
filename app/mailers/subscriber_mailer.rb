class SubscriberMailer < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subscriber_mailer.notify.subject
  #
  def notify(from, to, subject, message)
    @message = message

    mail to: to, from: from, subject: subject
  end

  def notify_about_new_event(subscriber, event)
    @event = event
    @username = event.user.name
    @eventname = event.name

    mail to: subscriber.email, subject: "#{@username} hat ein neues Event: '#{@eventname}'"
  end
end
