require 'rails_helper'

RSpec.describe Subscription, :type => :model do

  describe "#notify" do
    it "should send the right mails and deliver them for an event type" do
      user = User.create!(name: 'Username', email: 'test@test.de', password: 'testtest', password_confirmation: 'testtest' )
      event = Event.create(name: 'Test', description: 'Test description', user_id: user.id, start: Time.now, duration: 'Test duration')
      subscriber = Subscriber.create(email: 'subscriber@test.de')
      subscription = Subscription.create(subscriber_id: subscriber.id, subscribable_id: event.id, subscribable_type: 'Event')

      event_mail = double('Event Mail')
      expect(event_mail).to receive(:deliver).and_return(true)
      expect(SubscriptionMailer).to receive(:event).and_return(event_mail)

      subscriber_mail = double('Subscriber Mail')
      expect(subscriber_mail).to receive(:deliver).and_return(true)
      expect(SubscriptionMailer).to receive(:subscriber).and_return(subscriber_mail)

      subscription.notify
    end

    it "should send the right mails and deliver them for an user type" do
      user = User.create!(name: 'Username', email: 'test@test.de', password: 'testtest', password_confirmation: 'testtest' )
      subscriber = Subscriber.create(email: 'subscriber@test.de')
      subscription = Subscription.create(subscriber_id: subscriber.id, subscribable_id: user.id, subscribable_type: 'User')

      user_mail = double('User Mail')
      expect(user_mail).to receive(:deliver).and_return(true)
      expect(SubscriptionMailer).to receive(:user).and_return(user_mail)

      subscriber_mail = double('Subscriber Mail')
      expect(subscriber_mail).to receive(:deliver).and_return(true)
      expect(SubscriptionMailer).to receive(:subscriber).and_return(subscriber_mail)

      subscription.notify
    end
  end
end
