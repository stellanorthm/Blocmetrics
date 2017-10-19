class API::EventsController < ApplicationController

  skip_before_action :verify_authenticity_token

  before_filter :set_access_control_headers

   def set_access_control_headers
     headers['Access-Control-Allow-Origin'] = '*'
     headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
     headers['Access-Control-Allow-Headers'] = 'Content-Type'
   end

   def create
     @registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
     @event = Event.new(event_params)
     if @event.save
       flash[:notice] = "Event saved successfully."
       format.json { render json: @event, status: :created }
     else
       flash[:notice] = "There was an error saving the event. Please try again."
       format.json { render json: {errors: @event.errors}, status: :unprocessable_entity }
     end
   end

   def preflight
     head 200
   end

   private

   def event_params
     params.require(:event).permit(:name)
   end

 end
