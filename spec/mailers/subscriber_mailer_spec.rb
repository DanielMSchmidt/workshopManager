require "rails_helper"

RSpec.describe SubscriberMailer, :type => :mailer do
  describe "notify" do

    let(:mail) { SubscriberMailer.notify('from@test.org', 'to@test.org', 'test-subject', 'test-message') }

    it "renders the headers" do
      expect(mail.subject).to eq("test-subject")
      expect(mail.to).to eq(["to@test.org"])
      expect(mail.from).to eq(["from@test.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("test-message")
    end
  end

end
