class PicturesController < ApplicationController
  
  def new
    @picture=Picture.new(params[:picture])
  end
  
  
end