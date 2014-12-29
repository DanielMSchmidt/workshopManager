class SubscriptionMailer < ActionMailer::Base
  default from: "info@workshop-manager.herokuapp.com"

  def user(subscription)
    @subscription = subscription
    mail to: subscription.subscribable.email, subject: "Ein weiterer folgt dir"
  end

  def event(subscription)
    @subscription = subscription
    mail to: subscription.subscribable.user.email, subject: "Neue Anmeldung für #{subscription.subscribable.name}"
  end

  def subscriber(subscription)
    @subscription = subscription
    mail to: subscription.subscriber.email, subject: "Du hast dich erfolgreich angemeldet"
  end
end
