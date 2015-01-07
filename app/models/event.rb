class Event < ActiveRecord::Base
  belongs_to :user
  has_many :subscriptions, as: :subscribable
  has_many :subscribers, through: :subscriptions
  has_many :messages, as: :subscribable

  delegate :name, to: :user, prefix: true
  delegate :email, to: :user, prefix: false

  def notification_subject
    "Neue Informationen zu dem Workshop #{self.name}"
  end

  def add_subscriber(subscriber)
    Subscription.create(subscriber_id: subscriber.id, subscribable_type: 'Event', subscribable_id: self.id)
  end

  def notify_about_subscription(subscription)
    SubscriptionMailer.event(subscription).deliver
  end
end
