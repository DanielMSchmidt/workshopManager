class SubscriptionController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def new_for_user
    @user = User.find(params[:id])
  end

  def add
    AddSubscriptionService.run(params).match do
      success do |subscription|
        head :created
      end

      failure(:invalid_email) do |error|
        invalid_email = { error: "Die E-Mailadresse war nicht korrekt." }
        respond_with invalid_email, status: :not_acceptable
      end

      failure do |error|
        Rails.logger.debug "SubscriptionController#add -> failed because of #{error}"
        respond_with default_error, status: :bad_request
      end
    end
  end

  def notify
    NotifySubscribersService.run(params).match do
      success do |message|
        head :ok
      end

      failure do |error|
        Rails.logger.debug "SubscriptionController#notify -> failed because of #{error}"

        head :bad_request
      end
    end
  end

  def remove
    RemoveSubscriptionService.run(params).match do
      success do |result|
        head :ok
      end

      failure do |error|
        Rails.logger.debug "SubscriptionController#remove -> failed because of #{error}"
        head :bad_request
      end
    end
  end
end
