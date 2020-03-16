class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking)
    @puppies = Puppy.where(user_id: current_user)
    authorize @puppies
  end

  def new
    @booking = Booking.new
    @puppy = Puppy.find(params[:puppy_id])
    authorize @booking
  end

  def create
    @booking = Booking.new(params_booking)
    @booking.user_id = current_user.id
    @puppy = Puppy.find(params[:puppy_id])
    @booking.puppy = @puppy
    @booking.bookrequest = false
    @date_start = @booking.startdate.strftime("%Y-%m-%d")
    @date_end = @booking.enddate.strftime("%Y-%m-%d")
    found = false
    @all_bookings = Booking.all
    @all_bookings.each do |booking|
      arival_date = booking.startdate.strftime("%Y-%m-%d")
      leave_date = booking.enddate.strftime("%Y-%m-%d")
        if @date_start.between?(arival_date, leave_date) || @date_end.between?(arival_date, leave_date)
          if booking.puppy_id == @booking.puppy_id
            found = true
          end
        end
    end

  authorize @booking
  if found == true
    redirect_to puppy_path(@puppy), notice: "This pool is already booked in the period you want to book it.Try other dates(check the calendar)"
  else

    @booking.save
    authorize @booking
    redirect_to bookings_path
  end


end

  def show
    @booking = Booking.new
  end

  def edit
    @booking = Booking.find(params[:id])
    @booking.bookrequest = true

    #il faut envoyer le mail ici
    @booking.save
    authorize @booking
    redirect_to usermypuppies_path

  end

  def update
    # @sess
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.destroy
    authorize booking
    if booking.destroybyuser == false
      redirect_to bookings_path
    #Mail votre demande a été annulé
    else
      redirect_to usermypuppies_path
      # le propriétaire de la piscine a annulé votre reservation
    end


  end




  private
  def params_booking
    params.require(:booking).permit(:startdate, :enddate)
  end

end
