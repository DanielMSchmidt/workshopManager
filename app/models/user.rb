class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions, as: :subscribable
  has_many :subscribers, through: :subscriptions
  has_many :events

  def name
    # monkey patching, remove as soon as there is something in the database
    "Username"
  end

  def add_subscriber(subscriber)
    Subscription.create(subscriber_id: subscriber.id, subscribable_type: 'User', subscribable_id: self.id)
  end

  def notify_about_subscription(subscription)
    SubscriptionMailer.user(self).deliver
  end
end
