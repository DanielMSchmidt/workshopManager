class Event < ActiveRecord::Base
  include Subscribable
  belongs_to :user
end
