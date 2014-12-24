class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions, as: :subscribable
  has_many :events

  def subscribers
    self.subscriptions.map(&:subscribable)
  end

  def add_subscriber(subscriber)
    Subscription.create(subscriber_id: subscriber.id, subscribable_type: 'Event', subscribable_id: self.id)
  end
end
