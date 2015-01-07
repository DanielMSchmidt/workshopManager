class Message < ActiveRecord::Base
  belongs_to :subscribable, polymorphic: true
end
