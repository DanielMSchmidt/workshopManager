require "rails_helper"

RSpec.describe SubscriberMailer, :type => :mailer do
  describe "notify" do
    let(:mail) { SubscriberMailer.notify }

    it "renders the headers" do
      # expect(mail.subject).to eq("Notify")
      # expect(mail.to).to eq(["to@example.org"])
      # expect(mail.from).to eq(["from@example.com"])

      pending
    end

    it "renders the body" do
      # expect(mail.body.encoded).to match("Hi")

      pending
    end
  end

end
