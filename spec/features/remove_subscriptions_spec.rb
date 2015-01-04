require 'rails_helper'
require "base64"
require 'net/http'

feature "RemoveSubscriptions", :type => :feature do
  scenario "Unsubscribe to an event with valid token" do
    # Clean up
    Event.all.destroy_all
    Subscriber.all.destroy_all
    Subscription.all.destroy_all

    # Setup
    subscriber = Subscriber.create(email: "test@test.org")
    event = Event.create(name: 'test-event', description: 'test description', user_id: 1, start: Time.now, duration: '2 hours')
    token = Base64.encode64("Event,#{event.id},test@test.org")
    Subscription.create(subscriber_id: subscriber.id, subscribable_type: 'Event', subscribable_id: event.id)
    expect(event.subscriptions.count).to eq(1)
    expect(subscriber.subscriptions.count).to eq(1)

    # Test
    expect_any_instance_of(Subscription).to receive(:notify).at_least(:once)

    url = URI.parse(subscription_remove_path({unsubscribe_token: token}))
    req = Net::HTTP::Get.new(url.to_s)

    # Test model changes (maybe move into unit test)
    expect(RemoveSubscriptionService).to receive(:run)
    expect(event.subscriptions.count).to eq(0)
    expect(subscriber.subscriptions.count).to eq(0)
  end
end
