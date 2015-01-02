class Subscription < ActiveRecord::Base
  belongs_to :subscribable, polymorphic: true
  belongs_to :subscriber

  def notify
    subscribable.notify_about_subscription(self)
    SubscriptionMailer.subscriber(self).deliver
  end
end
