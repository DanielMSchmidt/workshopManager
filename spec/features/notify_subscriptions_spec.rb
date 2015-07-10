require 'rails_helper'

feature "NotifySubscriptions", :type => :feature do

  # TODO: Move these test to
  #         - Controller tests for post
  #         - React frontend tests (with jest or sth.)

  # before(:each) do
  #   password = 'testtest'

  #   # Clean up
  #   User.all.destroy_all
  #   Subscriber.all.destroy_all
  #   Subscription.all.destroy_all
  #   Event.all.destroy_all
  #   Message.all.destroy_all

  #   # Setup
  #   @user = User.create!(name: 'Username', email: 'tester@test.de', password: password, password_confirmation: password )
  #   @event = Event.create(name: 'test-event', description: 'test description', user_id: @user.id, start: Time.now, duration: '2 hours')
  #   @subscriber = Subscriber.create(email: 'subscriber@test.de')
  #   Subscription.create(subscribable_id: @event.id, subscribable_type: 'Event', subscriber_id: @subscriber.id)
  #   Subscription.create(subscribable_id: @user.id, subscribable_type: 'User', subscriber_id: @subscriber.id)

  #   # Check if it works
  #   expect(Message.count).to eq(0)
  #   expect(Subscription.count).to eq(2)
  #   expect(User.find(@user.id)).to eq(@user)
  #   expect(Event.find(@event.id)).to eq(@event)
  #   expect(Subscriber.find(@subscriber.id)).to eq(@subscriber)

  #   # Sign in
  #   visit new_user_session_path
  #   fill_in "Email", with: @user.email
  #   fill_in "Password", with: password
  #   click_button "Anmelden"
  # end

  # scenario "Authorized user sends notification for event", :js => true do
  #   expect(@event.subscribers.first).to eq(@subscriber)
  #   expect_any_instance_of(SubscriberMailer).to receive(:notify).with('tester@test.de', 'subscriber@test.de', 'Neue Informationen zu dem Workshop test-event', 'My great message')

  #   visit event_path(@event)
  #   expect(page).to have_text("test-event von")
  #   p "current URL: #{page.current_url}"
  #   fill_in "newMessage", with: "My great message"
  #   expect(page).to have_field('newMessage', with: 'My great message')
  #   click_button "Absenden"

  #   expect(page.status_code).to eq(200)
  #   expect(Message.count).to eq(1)
  #   expect(@event.messages.count).to eq(1)
  # end

  # scenario "Authorized user sends notification for self", :js => true do
  #   expect(@user.subscribers.first).to eq(@subscriber)
  #   expect_any_instance_of(SubscriberMailer).to receive(:notify).with('tester@test.de', 'subscriber@test.de', 'Neue Infos über Username', 'My great message')

  #   visit message_index_path
  #   expect(page).to have_text("Versende eine Nachricht an alle deine Anhänger")
  #   fill_in "message", with: "My great message"
  #   click_button "Absenden"

  #   expect(page.status_code).to eq(200)
  #   expect(Message.count).to eq(1)
  #   expect(user.messages.count).to eq(1)
  # end

  # scenario "Authorized user sends empty message", :js => true do
  #   expect(@event.subscribers.first).to eq(@subscriber)
  #   expect_any_instance_of(SubscriberMailer).to_not receive(:notify).with('tester@test.de', 'subscriber@test.de', 'Neue Informationen zu dem Workshop test-event', 'My great message')

  #   visit event_path(@event)
  #   expect(page).to have_text("test-event von")
  #   click_button "Absenden"

  #   expect(page.status_code).to eq(400)
  #   expect(Message.count).to eq(0)
  # end
end
