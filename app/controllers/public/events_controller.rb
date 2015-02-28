module Public
  class EventsController < ApplicationController
    before_action :set_event
    respond_to :html

    def show
    end

    private
      def set_event
        @event = Event.find(params[:id])
      end
  end
end
