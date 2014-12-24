class SubscriptionController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def add
    AddSubscriptionService.run(params).match do
      success do |subscription|
        render "add"
      end

      failure(:invalid_email) do |error|
        render "invalid_email"
      end

      failure do |error|
        render inline: "Da ist etwas fehlgeschlagen!"
      end
    end
  end

  def remove
  end
end
