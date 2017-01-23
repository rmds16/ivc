class EventsController < ApplicationController

  def new
    @event = Event.new
    if params['date']
      @event.start_date = Date.parse(params['date']) 
      @event.end_date = Date.parse(params['date'])
    end
  end

  def index
    render json: Event.all.to_json(methods: :start )
    return [] unless params['start'] && params['end']

    start_date = Date.parse(params['start'])
    end_date = Date.parse(params['end'])

    render json: Event.where(start_date: start_date..end_date).to_json
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