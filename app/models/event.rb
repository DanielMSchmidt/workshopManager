class Event < ActiveRecord::Base
  belongs_to :user
  has_many :subscriptions, as: :subscribable

  def subscribers
    self.subscriptions.map(&:subscribable)
  end

  def add_subscriber(subscriber)
    Subscription.create(subscriber_id: subscriber.id, subscribable_type: 'Event', subscribable_id: self.id)
  end
end
