class Subscription < ActiveRecord::Base
  belongs_to :subscribable, polymorphic: true
  belongs_to :subscriber
end
