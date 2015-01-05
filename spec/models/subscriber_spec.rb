require 'rails_helper'

RSpec.describe Subscriber, :type => :model do

  describe "#notify" do
    it "should send an email from the event owner to self with right message"
    it "should send an email from user to self with right message"
  end
end
