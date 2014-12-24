class SubscriptionMailer < ActionMailer::Base
  default from: "from@example.com"

  def user(subscription)
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def event(subscription)
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def subscriber(subscription)
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
