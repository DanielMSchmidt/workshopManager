class Event < ActiveRecord::Base
  belongs_to :user
  has_many :subscriptions, as: :subscribable
  has_many :subscribers, through: :subscriptions

  delegate :name, to: :user, prefix: true

  def add_subscriber(subscriber)
    Subscription.create(subscriber_id: subscriber.id, subscribable_type: 'Event', subscribable_id: self.id)
  end

  def notify_about_subscription(subscription)
    SubscriptionMailer.event(subscription).deliver
  end
end
