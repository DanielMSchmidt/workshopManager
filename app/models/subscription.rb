class Subscription < ActiveRecord::Base
  belongs_to :subscribable, polymorphic: true
  belongs_to :subscriber

  def notify
    if self.subscribable.class == "Event"
      SubscriptionMailer.event(self).deliver
    elsif self.subscribable.class == "User"
      SubscriptionMailer.user(self).deliver
    end

    SubscriptionMailer.subscriber(self).deliver
  end
end
