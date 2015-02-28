require 'rails_helper'

feature "AddSubscriptions", :type => :feature do
  scenario "Unknown subscriber subscribes to an event" do
    # Clean up
    Event.all.destroy_all
    Subscriber.all.destroy_all
    Subscription.all.destroy_all

    # Setup
    event = Event.create(name: 'test-event', description: 'test description', user_id: 1, start: Time.now, duration: '2 hours')

    # Test
    expect_any_instance_of(Subscription).to receive(:notify).at_least(:once)

    visit subscribe_event_path(event)
    fill_in "email", :with => "test@test.org"
    click_button "Anmelden"
    expect(page.status_code).to eq(201)

    # Test model changes (maybe move into unit test)
    subscriber = Subscriber.where(email: "test@test.org").first

    expect(event.subscriptions.count).to eq(1)
    expect(Subscriber.count).to eq(1)
    expect(event.subscriptions.first.subscriber).to eq(subscriber)
  end

  scenario "Known subscriber subscribes to an event" do
    # Clean up
    Event.all.destroy_all
    Subscriber.all.destroy_all
    Subscription.all.destroy_all

    # Setup
    event = Event.create(name: 'test-event', description: 'test description', user_id: 1, start: Time.now, duration: '2 hours')
    subscriber = Subscriber.create(email: "test@test.org")

    # Test
    expect_any_instance_of(Subscription).to receive(:notify).at_least(:once)

    visit subscribe_event_path(event)
    fill_in "email", :with => "test@test.org"
    click_button "Anmelden"
    expect(page.status_code).to eq(201)

    # Test model changes (maybe move into unit test)
    expect(event.subscriptions.count).to eq(1)
    expect(Subscriber.count).to eq(1)
    expect(event.subscriptions.first.subscriber).to eq(subscriber)
  end

  scenario "Unknown subscriber subscribes to an user" do
    # Clean up
    User.all.destroy_all
    Subscriber.all.destroy_all
    Subscription.all.destroy_all

    # Setup
    user = User.create!(name: 'Username', email: 'tester@test.de', password: 'testtest', password_confirmation: 'testtest' )

    # Test
    expect_any_instance_of(Subscription).to receive(:notify).at_least(:once)

    visit subscribe_user_path(user)
    fill_in "email", :with => "test@test.org"
    click_button "Anmelden"
    expect(page.status_code).to eq(201)

    # Test model changes (maybe move into unit test)
    subscriber = Subscriber.where(email: "test@test.org").first

    expect(user.subscriptions.count).to eq(1)
    expect(Subscriber.count).to eq(1)
    expect(user.subscriptions.first.subscriber).to eq(subscriber)
  end

  scenario "Known subscriber subscribes to an user" do
    # Clean up
    User.all.destroy_all
    Subscriber.all.destroy_all
    Subscription.all.destroy_all

    # Setup
    user = User.create!(name: 'Username', email: 'tester@test.de', password: 'testtest', password_confirmation: 'testtest' )
    subscriber = Subscriber.create(email: "test@test.org")

    # Test
    expect_any_instance_of(Subscription).to receive(:notify).at_least(:once)

    visit subscribe_user_path(user)
    fill_in "email", :with => "test@test.org"
    click_button "Anmelden"
    expect(page.status_code).to eq(201)

    # Test model changes (maybe move into unit test)
    expect(user.subscriptions.count).to eq(1)
    expect(Subscriber.count).to eq(1)
    expect(user.subscriptions.first.subscriber).to eq(subscriber)
  end
end
