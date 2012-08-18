class PicturesController < ApplicationController
  before_filter :authenticate_user!
  def new
    @picture=Picture.new(params[:picture])
  end
  
  
end
