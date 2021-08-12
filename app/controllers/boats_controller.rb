class BoatsController < ApplicationController
  before_action :find_boat, only: [ :show ]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:address] == nil || params[:address].empty?
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
    @markers = [{
        lat: @boat.latitude,
        lng: @boat.longitude
      }]
  end

  def new
    @boat = Boat.new()
  end

  def create
    @boat = Boat.new(boat_params)
    @boat.user = current_user
    if @boat.save
			redirect_to boat_path(@boat)
		else
			render :new
		end
  end

  def my_boats
    @my_boats = Boat.where(user: current_user)
  end

  private 

  def find_boat
    @boat = Boat.find(params[:id])
  end

  def boat_params
    params.require(:boat).permit(:name, :price, :description, :address, :photo)
  end
end
