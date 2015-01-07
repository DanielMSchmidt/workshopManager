class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions, as: :subscribable
  has_many :subscribers, through: :subscriptions
  has_many :events
  has_many :messages, as: :subscribable

  validates :name, :email, presence: true

  def add_subscriber(subscriber)
    Subscription.create(subscriber_id: subscriber.id, subscribable_type: 'User', subscribable_id: self.id)
  end

  def notify_about_subscription(subscription)
    SubscriptionMailer.user(self).deliver
  end

  def notification_subject
    "Neue Infos über #{self.name}"
  end
end
