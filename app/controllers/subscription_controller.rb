class SubscriptionController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new_for_user
    @user = User.find(params[:id])
  end

  def add
    AddSubscriptionService.run(params).match do
      success do |subscription|
        render "add"
      end

      failure(:invalid_email) do |error|
        render "invalid_email"
      end

      failure do |error|
        Rails.logger.debug "SubscriptionController#add -> failed because of #{error}"
        render inline: "Da ist etwas fehlgeschlagen!"
      end
    end
  end

  def notify
    NotifySubscribersService.run(params).match do
      success do |message|
        render inline: "Nachricht versendet!"
      end

      failure do |error|
        Rails.logger.debug "SubscriptionController#notify -> failed because of #{error}"
        render inline: "Da ist etwas fehlgeschlagen!"
      end
    end
  end

  def remove
    RemoveSubscriptionService.run(params).match do
      success do |result|
        render "remove"
      end

      failure do |error|
        Rails.logger.debug "SubscriptionController#remove -> failed because of #{error}"
        render inline: "Da ist etwas fehlgeschlagen!"
      end
    end
  end
end
