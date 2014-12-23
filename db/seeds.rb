unless Rails.env.production?
  user = User.create!(email: 'test@test.de', password: 'testtest', password_confirmation: 'testtest' )
  event = Event.create!(user_id: user.id, name: 'Test Event', description: 'Testdescription', start: Time.now, duration: 1.5)
  event_subscriber = Subscriber.create!(email: 'event_subscriber@test.de')
  user_subscriber = Subscriber.create!(email: 'user_subscriber@test.de')

  # Event subscription
  Subscription.create!(subscriber_id: event_subscriber.id, subscribable_id: event.id, subscribable_type: 'Event')

  # User subscription
  Subscription.create!(subscriber_id: user_subscriber.id, subscribable_id: user.id, subscribable_type: 'User')
end
