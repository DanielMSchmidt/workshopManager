class Subscriber < ActiveRecord::Base
  has_many :subscriptions

  def notify(subscribable, message)
    # TODO: send message from subscribable to self
    subscribable_email = 'Get the email from subscribable'
    subject = 'Get subject from subscribable'

    SubscriberMailer.notify(subscribable_email, self.email, subject, message).deliver
  end
end
