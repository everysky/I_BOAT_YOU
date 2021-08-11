class BoatsController < ApplicationController
  before_action :find_boat, only: [ :show ]
  def index
    if params[:address] == nil
      @boats = Boat.all
    else
      @boats = Boat.near(params[:address], 10)
    end
    @markers = @boats.geocoded.map do |boat|
      {
        lat: boat.latitude,
        lng: boat.longitude
      }
    end
  end

  def show
  end

  def new
    @boat = Boat.new()
  end

  def create
    @boat = Boat.new(boat_params)
    if @boat.save
			redirect_to boat_path(@boat.id)
		else
			render :new
		end
    
  end

  private 

  def find_boat
    @boat = Boat.find(params[:id])
  end

  def boat_params
    params.require(:boat).permit(:name, :location, :description)
  end
end
