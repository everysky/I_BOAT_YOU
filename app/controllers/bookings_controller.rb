class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :my_bookings]
  def index
    # @bookings = Booking.all
  end

  def my_bookings
    # #upcomming_bookings is a scope written in model booking.rb
    # @my_upcomming_bookings = Booking.upcomming(current_user).order(start_date: :desc)
    @my_upcomming_bookings = current_user.bookings.upcomming.order(start_date: :desc)
    @my_past_bookings = current_user.bookings.past.order(start_date: :desc)
  end

  # def show
  #   @booking = Booking.find(params[:id])
  # end

  def new
    @booking = Booking.new # needed to instantiate the form_for
    @boat = Boat.find(params[:boat_id])
    @booking.start_date = params[:debut].to_date
    @booking.end_date = params[:fin].to_date
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.boat = Boat.find(params[:boat_id])
    @booking.invoice = ((@booking.end_date - @booking.start_date).to_i.abs + 1) * @booking.boat.price
    # @booking.invoice = 
    # Will raise ActiveModel::ForbiddenAttributesError
    # byebug
    if @booking.save
      redirect_to my_bookings_path()
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
