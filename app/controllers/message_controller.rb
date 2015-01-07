class MessageController < ApplicationController
  before_action :authenticate_user!

  def index
  end
end
