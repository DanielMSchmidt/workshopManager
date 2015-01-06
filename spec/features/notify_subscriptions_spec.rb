require 'rails_helper'

feature "NotifySubscriptions", :type => :feature do
  scenario "Authorized user sends notification for event" do
    # Clean up
    User.all.destroy_all
    Subscriber.all.destroy_all
    Subscription.all.destroy_all
    Event.all.destroy_all

    # Setup
    user = User.create!(email: 'tester@test.de', password: 'testtest', password_confirmation: 'testtest' )
    event = Event.create(name: 'test-event', description: 'test description', user_id: user.id, start: Time.now, duration: '2 hours')
    subscriber = Subscriber.create(email: 'subscriber@test.de')
    Subscription.create(subscribable_id: event.id, subscribable_type: 'Event', subscriber_id: subscriber.id)

    # Sign in
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "testtest"
    click_button "Log in"

    # Test
    expect(event.subscribers.first).to eq(subscriber)
    expect_any_instance_of(SubscriberMailer).to receive(:notify).with('tester@test.de', 'subscriber@test.de', 'Neue Informationen zu dem Workshop test-event', 'My great message')

    visit event_path(event)
    expect(page).to have_text("test-event von")
    fill_in "message", with: "My great message"
    click_button "Absenden"
    expect(page).to have_text("Nachricht versendet!")
  end

  scenario "Authorized user sends notification for self"
  scenario "Unauthorized user sends notification for event"
  scenario "Unauthorized user sends notification for another user"
  scenario "Authorized user sends empty message"
end
