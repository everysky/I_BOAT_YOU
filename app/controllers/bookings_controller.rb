class BookingsController < ApplicationController
  # def index
  #   @bookings = Booking.all
  # end

  # def show
  #   @booking = Booking.find(params[:id])
  # end

  def new
    @booking = Booking.new # needed to instantiate the form_for
    @boat = Boat.find(params[:boat_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.boat = Boat.find(params[:boat_id])
    # @booking.invoice = 
    # Will raise ActiveModel::ForbiddenAttributesError
    # byebug
    if @booking.save
      redirect_to boat_path(@booking.boat)
      # Le bateau a bien été reservé. vous pouvez retrouver vos reservations sur votre profil
    else
      @boat = Boat.find(params[:boat_id])
      render :new
    end
  end

  # def edit
  #   @booking = Booking.find(params[:id])
  # end

  # def update
  #   @booking = Booking.find(params[:id])
  #   @booking.update(booking_params)
  #   # Will raise ActiveModel::ForbiddenAttributesError
  #   redirect_to booking_path(@booking)
  # end

  # def destroy
  #   @booking = Booking.find(params[:id])
  #   @booking.destroy
  #   # no need for app/views/bookings/destroy.html.erb
  #   redirect_to bookings_path
  # end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
