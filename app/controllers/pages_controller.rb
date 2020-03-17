class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @pool = Pool.new
  end


end
