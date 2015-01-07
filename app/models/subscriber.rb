class Subscriber < ActiveRecord::Base
  has_many :subscriptions

  def notify(subscribable, message)
    SubscriberMailer.notify(subscribable.email, self.email, subscribable.notification_subject, message).deliver
  end
end
