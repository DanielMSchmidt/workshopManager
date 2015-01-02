require 'rails_helper'

feature "AddSubscriptions", :type => :feature do
  scenario "Unknown users subscribes to an event" do
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
    expect(page).to have_text("Sie wurden erfolgreich angemeldet.")

    # Test model changes (maybe move into unit test)
    subscriber = Subscriber.where(email: "test@test.org").first

    expect(event.subscriptions.count).to eq(1)
    expect(Subscriber.count).to eq(1)
    expect(event.subscriptions.first.subscriber).to eq(subscriber)
  end

  scenario "Known users subscribes to an event" do
    pending
  end

  scenario "Unknown users subscribes to an user" do
    pending
  end

  scenario "Known users subscribes to an user" do
    pending
  end
end
