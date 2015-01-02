class AddSubscriptionService
  include SolidUseCase

  steps :validate_email, :get_subscribable, :add_subscriber, :notify_about_subscription

  # Check if subscriber mail is correct
  def validate_email(params)
    subscriber = Subscriber.find_or_initialize_by(email: params[:email])

    if subscriber.valid?
      subscriber.save
      params[:subscriber] = subscriber
      continue(params)
    else
      fail :invalid_email
    end
  end

  def get_subscribable (params)
    if params[:subscribable_id].present? && params[:subscribable_type].present?
      subscribable = params[:subscribable_type].constantize.find(params[:subscribable_id])
      params[:subscribable] = subscribable
      continue(params)
    else
      fail :no_subscribable_found
    end
  end

  # Add subscriber
  def add_subscriber(params)
    subscriber = params[:subscriber]
    subscribable = params[:subscribable]

    params[:subscription] = subscribable.add_subscriber(subscriber)
    continue(params)
  end

  # Notify subscriber about subscription
  def notify_about_subscription(params)
    begin
      params[:subscription].notify
      continue(params)
    rescue
      fail :could_not_send_notification
    end
  end
end
