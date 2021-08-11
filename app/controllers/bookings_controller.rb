class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new # needed to instantiate the form_for
  end

  def create
    @booking = Booking.new(booking_params)
    # Will raise ActiveModel::ForbiddenAttributesError
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    # Will raise ActiveModel::ForbiddenAttributesError
    redirect_to booking_path(@booking)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    # no need for app/views/bookings/destroy.html.erb
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:name, :address, :phone_number, :category)
  end
end
