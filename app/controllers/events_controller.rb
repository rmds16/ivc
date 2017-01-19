class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def index
    render json: Event.all.to_json(methods: :start )
  end

  def create
    @event = Event.new(params[:event].permit!)
    if @event.save!
      flash[:notice] = "Event created!"
      redirect_back_or_default calendar_path
    else
      render action: :new
    end
  end
  
  def show
    @event = Event.find_by(id: params[:id])
  end

  def edit
    @event = Event.find_by(id: params[:id])
  end
  
  def update
    @event = Event.find_by(id: params[:id])
    if @event.update_attributes(params[:event].permit!)
      flash[:notice] = "Event updated!"
      redirect_to calendar_path
    else
      render action: :edit
    end
  end
end