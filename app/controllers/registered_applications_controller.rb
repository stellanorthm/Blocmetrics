class RegisteredApplicationsController < ApplicationController

  before_action :authenticate_user!

  def index
    @registered_applications = RegisteredApplication.all
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
    @events = @registered_application.events.group_by(&:name)
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def create
     @application = RegisteredApplication.new
     @application.name = params[:application][:name]
     @application.url = params[:application][:url]
     @application.user = current_user
     if @application.save
       flash[:notice] = "Application was registered."
       redirect_to @application
     else
       flash.now[:alert] = "There was an error registering the application. Please try again."
       render :new
     end
   end

  def update
  end

  def edit
  end

  def destroy
    @registered_application = RegisteredApplication.find(params[:id])
    if @registered_application.destroy
       flash[:notice] = "\"#{@registered_application.name}\" was deleted successfully."
       redirect_to registered_applications_path
     else
       flash.now[:alert] = "There was an error deleting the application."
       render :show
     end
  end

end
