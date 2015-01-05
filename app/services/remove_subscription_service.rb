require "base64"

class RemoveSubscriptionService
  include SolidUseCase

  steps :check_token, :decode_token, :get_subscriber, :get_subscription, :notify, :remove_subscription

  # Check if token is given
  def check_token(params)
    if params[:unsubscribe_token].nil?
      fail(:no_token_given)
    else
      continue(params[:unsubscribe_token])
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

  # Get the subscriber
  def get_subscriber(params)
    subscriber = Subscriber.where(email: params[:email]).first
    unless subscriber.nil?
      params[:subscriber] = subscriber
      continue(params)
    else
      fail(:unknown_subscriber)
    end
  end

  # Get the subscription
  def get_subscription(params)
    subscription = Subscription.where(subscribable_type: params[:subscribable_type], subscribable_id: params[:subscribable_id], subscriber_id: params[:subscriber].id)
    unless subscription.first.nil?
      params[:subscription] = subscription.first
      continue(params)
    else
      fail(:unknown_subscription)
    end
  end

  # Remove subscription
  def remove_subscription(params)
    if params[:subscription].destroy
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
