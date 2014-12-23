module Subscribable
    extend ActiveSupport::Concern

    included do
        has_many :subscribers, as: :subscribable
    end
end