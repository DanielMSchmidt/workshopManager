class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions, as: :subscribable
  has_many :events

  def subscribers
    self.subscriptions.map(&:subscribable)
  end

  def add_subscriber(subscriber)
    Subscription.create(subscriber_id: subscriber.id, subscribable_type: 'User', subscribable_id: self.id)
  end

  def notify_about_subscription(subscription)
    SubscriptionMailer.user(self).deliver
  end
end
