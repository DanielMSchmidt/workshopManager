require 'rails_helper'

RSpec.describe Subscriber, :type => :model do

  describe "#notify" do
    before(:each) do
      Subscriber.all.destroy_all
      Event.all.destroy_all
      User.all.destroy_all
    end

    it "should send an email from the event owner to self with right message" do
      user = User.create!(name: 'Username', email: 'test@test.de', password: 'testtest', password_confirmation: 'testtest' )
      subscriber = Subscriber.create(email: 'subscriber@test.de')
      subscribable = Event.create(name: 'test-event', description: 'test description', user_id: user.id, start: Time.now, duration: '2 hours')
      message = "This message should be send"

      event_mail = double('Event Mail')
      expect(event_mail).to receive(:deliver).and_return(true)
      expect(SubscriberMailer).to receive(:notify).with('test@test.de', 'subscriber@test.de', 'Neue Informationen zu dem Workshop test-event', message).and_return(event_mail)

      subscriber.notify(subscribable, message)
    end

    it "should send an email from user to self with right message" do
      subscribable = User.create!(name: 'Username', email: 'test@test.de', password: 'testtest', password_confirmation: 'testtest' )
      subscriber = Subscriber.create(email: 'subscriber@test.de')
      message = "This message should be send"

      user_mail = double('User Mail')
      expect(user_mail).to receive(:deliver).and_return(true)
      expect(SubscriberMailer).to receive(:notify).with('test@test.de', 'subscriber@test.de', 'Neue Infos über Username', message).and_return(user_mail)

      subscriber.notify(subscribable, message)
    end
  end
end
