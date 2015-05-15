module Public
  class UserController < Public::BaseController
    respond_to :html

    UPCOMING_EVENT = -> e { e.start < Date.today }

    def show
      @user = User.find(params[:id])
      events = @user.events.all
      @upcoming_events = events.reject(&UPCOMING_EVENT)
      @finished_events = events.select(&UPCOMING_EVENT)
      @subscribers = @user.subscriptions.map(&:subscriber).map(&:email)
    end
  end
end
