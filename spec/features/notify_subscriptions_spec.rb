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

    # Test
    visit event_path(event)
    fill_in "message", :with => "My great message"
    click_button "Absenden"
    expect(page).to have_text("Nachricht versendet!")

    # Test that there should be a message send
    expect(subscriber).to receive(:notify).with(event, "My great message")
  end

  scenario "Authorized user sends notification for self"
  scenario "Unauthorized user sends notification for event"
  scenario "Unauthorized user sends notification for another user"
  scenario "Authorized user sends empty message"
end
