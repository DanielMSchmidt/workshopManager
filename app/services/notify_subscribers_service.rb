class NotifySubscribersService
  include SolidUseCase

  steps :validate_subscribable_type, :get_subscribable, :check_message, :persist_message, :notfiy_subscribers

  # Validate subscribable type
  def validate_subscribable_type(params)
    if params[:subscribable_type].in? ['Event', 'User']
      continue(params)
    else
      fail(:unknown_subscribable_type)
    end
  end

  # Check if subscribable is given and get it
  def get_subscribable(params)
    params[:subscribable] = params[:subscribable_type].constantize.find(params[:subscribable_id])
    unless params[:subscribable].nil?
      continue(params)
    else
      fail(:no_subscribable_found)
    end
  end

  # Check if message is valid
  def check_message(params)
    unless params[:message].blank?
      continue(params)
    else
      fail(:no_message_given)
    end
  end

  # Build and save a message object
  def persist_message(params)
    message = params[:subscribable].messages.create(content: params[:message])
    params[:message_object] = message
    continue(params)
  end

  # Send message to each subscriber
  def notfiy_subscribers(params)
    subject = params[:subscribable]

    subject.subscribers.each do |subscriber|
      subscriber.notify(subject, params[:message])
    end

    continue(params)
  end
end
