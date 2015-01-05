class Subscriber < ActiveRecord::Base
  has_many :subscriptions

  def notify(subscribable, message)
    # TODO: send message from subscribable to self
  end
end
