require "base64"

class RemoveSubscriptionService
  include SolidUseCase

  steps :check_token, :decode_token, :remove_subscription, :notify

  # Check if token is given
  def check_token(params)
    if params[:token].nil?
      fail(:no_token_given)
    else
      continue(params[:token])
    end
  end

  # Get subscribable and subscriber from token
  def decode_token(encoded_token)
    params = {}
    token_parts = Base64.decode64(encoded_token).split(',')

    params[:subscribable_type] = token_parts[0]
    params[:subscribable_id] = token_parts[1]
    params[:email] = token_parts[2]

    if params[:subscribable_type] && params[:subscribable_id] && params[:email]
      continue(params)
    else
      fail(:format_wrong)
    end
  end

  # Remove subscription
  def remove_subscription(params)
    subscription = Subscription.where(subscribable_type: params[:subscribable_type], subscribable_id: params[:subscribable_id], email: params[:email])
    if subscription.destroy
      params[:subscription] = subscription
      continue(params)
    else
      fail(:could_not_destroy)
    end
  end

  # Notify owner and subscriber
  def notify(params)
    subscribable = params[:subscription].subscribable
    if(subscribable.class == Event)
      SubscriptionMailer.remove_event(params[:subscription]).deliver
    else
      SubscriptionMailer.remove_user(params[:subscription]).deliver
    end
    SubscriptionMailer.remove_subscriber(params[:subscription]).deliver

    continue(params)
  end
end
