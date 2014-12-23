class SubscriptionController < ApplicationController
  def add
    AddSubscription.run(params).match do
      success do |subscription|
        render "add"
      end

      failure(:invalid_email) do |error|
        render "invalid_email"
      end
    end
  end

  def remove
  end
end
