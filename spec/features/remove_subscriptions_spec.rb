require 'rails_helper'
require 'base64'


feature "RemoveSubscriptions", :type => :feature do
  scenario "Unsubscribe to an event with valid token" do
    # Clean up
    Event.all.destroy_all
    Subscriber.all.destroy_all
    Subscription.all.destroy_all

    # Setup
    subscriber = Subscriber.create(email: "test@test.org")
    user = User.create!(name: 'Username', email: 'tester@test.de', password: 'testtest', password_confirmation: 'testtest' )
    event = Event.create(name: 'test-event', description: 'test description', user_id: user.id, start: Time.now, duration: '2 hours')
    token = Base64.encode64("Event,#{event.id},test@test.org")
    Subscription.create(subscriber_id: subscriber.id, subscribable_type: 'Event', subscribable_id: event.id)
    expect(event.subscriptions.count).to eq(1)
    expect(subscriber.subscriptions.count).to eq(1)

    # Test
    visit subscription_remove_path({unsubscribe_token: token})

    # Test model changes
    expect(event.subscriptions.count).to eq(0)
    expect(subscriber.subscriptions.count).to eq(0)
  end

  scenario "Unsubscribe to an user with valid token" do
    # Clean up
    Event.all.destroy_all
    User.all.destroy_all
    Subscriber.all.destroy_all
    Subscription.all.destroy_all

    # Setup
    subscriber = Subscriber.create(email: "test@test.org")
    user = User.create!(name: 'Username', email: 'tester@test.de', password: 'testtest', password_confirmation: 'testtest' )
    token = Base64.encode64("User,#{user.id},test@test.org")
    Subscription.create(subscriber_id: subscriber.id, subscribable_type: 'User', subscribable_id: user.id)
    expect(user.subscriptions.count).to eq(1)
    expect(subscriber.subscriptions.count).to eq(1)

    # Test
    visit subscription_remove_path({unsubscribe_token: token})

    # Test model changes
    expect(user.subscriptions.count).to eq(0)
    expect(subscriber.subscriptions.count).to eq(0)
  end

  scenario "Unsubscribe to an event with completely invalid token" do
    # Clean up
    Event.all.destroy_all
    User.all.destroy_all
    Subscriber.all.destroy_all
    Subscription.all.destroy_all

    # Setup
    subscriber = Subscriber.create(email: "test@test.org")
    user = User.create!(name: 'Username', email: 'tester@test.de', password: 'testtest', password_confirmation: 'testtest' )
    token = "completelyuselesstoken"
    Subscription.create(subscriber_id: subscriber.id, subscribable_type: 'User', subscribable_id: user.id)
    expect(user.subscriptions.count).to eq(1)
    expect(subscriber.subscriptions.count).to eq(1)

    # Test
    get subscription_remove_path({unsubscribe_token: token})

    # Test model changes
    expect(user.subscriptions.count).to eq(1)
    expect(subscriber.subscriptions.count).to eq(1)
  end

  scenario "Unsubscribe to an event with unknown subscriber" do
    # Clean up
    Event.all.destroy_all
    User.all.destroy_all
    Subscriber.all.destroy_all
    Subscription.all.destroy_all

    # Setup
    subscriber = Subscriber.create(email: "test@test.org")
    user = User.create!(name: 'Username', email: 'tester@test.de', password: 'testtest', password_confirmation: 'testtest' )
    token = Base64.encode64("User,#{user.id},unknown@test.org")
    Subscription.create(subscriber_id: subscriber.id, subscribable_type: 'User', subscribable_id: user.id)
    expect(user.subscriptions.count).to eq(1)
    expect(subscriber.subscriptions.count).to eq(1)

    # Test
    visit subscription_remove_path({unsubscribe_token: token})

    # Test model changes
    expect(user.subscriptions.count).to eq(1)
    expect(subscriber.subscriptions.count).to eq(1)
  end

  scenario "Unsubscribe where no subscription exists" do
    # Clean up
    Event.all.destroy_all
    User.all.destroy_all
    Subscriber.all.destroy_all
    Subscription.all.destroy_all

    # Setup
    subscriber = Subscriber.create(email: "test@test.org")
    user = User.create!(name: 'Username', email: 'tester@test.de', password: 'testtest', password_confirmation: 'testtest' )
    token = Base64.encode64("User,#{user.id},test@test.org")
    expect(user.subscriptions.count).to eq(0)
    expect(subscriber.subscriptions.count).to eq(0)

    # Test
    visit subscription_remove_path({unsubscribe_token: token})

    # Test model changes
    expect(user.subscriptions.count).to eq(0)
    expect(subscriber.subscriptions.count).to eq(0)
  end
end
