class PoolsController < ApplicationController
  skip_before_action :authenticate_user!, only:[:index,:show]
  before_action :find_pool, only:[:edit,:destroy,:update]

  def index

    @pools = policy_scope(Pool).order(created_at: :desc)


    if params[:search]

  @pools = Pool.search_by_location_and_option(params[:search])
  else
  @pools = Pool.all
  end

    # @pools = Pool.geocoded #returns flats with coordinates
    @markers = @pools.map do |pool|
      {
        lat: pool.latitude,
        lng: pool.longitude,
         infoWindow: render_to_string(partial: "shared/info_window", locals: { pool: pool }),
         image_url: helpers.asset_url('https://res.cloudinary.com/dnwnxu6xb/image/upload/v1582985080/240609_lhqk3a.svg')
      }
    end
  end

    def mypools
      @booking =[]
      @pools = Pool.where(user_id: current_user)
      @pools.each do |pool|

        booking = Booking.where(pool_id: pool.id )

        if booking.count > 1 then
          booking.each do |booking|
            @booking << booking
          end
        elsif booking.count == 1
          @booking << booking[0]
        end

        @allbookings = Booking.all
      end
      authorize @pools
    end



  def new
    @pool = Pool.new
    authorize @pool
  end

  def create

    @pool = Pool.new(params_puppy)
    authorize @pool
    @pool.user = current_user

    @pool.latitude = @pool.geocode[0]
    @pool.longitude = @pool.geocode[1]


    if @pool.save
      redirect_to pools_path
    else
      render :new
    end
  end

  def show
    @booking = Booking.new
    @pool = Pool.find(params[:id])
    @reviews = Review.where(pool: @pool)
    @review = Review.new

    @review.pool_id = @pool.id


  @bookingsconfirmed =[]

  booking = Booking.where(pool_id: @pool.id )

        if booking.count > 1 then
          booking.each do |booking|
            @bookingsconfirmed << booking
              end
        elsif booking.count == 1
          @bookingsconfirmed << booking[0]
        end




  authorize @pool
  @markers =
        {
          lat: @pool.latitude,
          lng: @pool.longitude,
           infoWindow: render_to_string(partial: "shared/info_window", locals: { pool: @pool }),
           image_url: helpers.asset_url('https://res.cloudinary.com/dnwnxu6xb/image/upload/v1582985080/240609_lhqk3a.svg')
        }

  end

  def edit


  end

  def update
    @pool.update(params_puppy)
    redirect_to pools_path
  end

  def destroy

    @pool.destroy
    redirect_to pools_path
  end

  private
  def params_puppy
    params.require(:pool).permit(:name, :photo, :nbpeople, :price, :availability, :option, :location)
  end

  def find_pool
     @pool = Pool.find(params[:id])
     authorize @pool
  end


end
