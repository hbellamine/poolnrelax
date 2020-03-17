class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only:[:new, :create]
  def new
  end

  def create
    @review = Review.new(params_reviews)
    authorize @review
    @pool = Pool.find(params[:pool_id])
    @review.pool = @pool

    if @review.save
      respond_to do |format|
        format.html { redirect_to pool_path(@review.pool_id) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'pools' }
        format.js  # <-- idem
        end
    end
  end

 private
  def params_reviews
    params.require(:review).permit(:content, :rating, :pool_id)
  end



end
