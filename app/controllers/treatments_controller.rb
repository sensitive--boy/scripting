class TreatmentsController < ApplicationController
  def new
  end

  def edit
    @treatment=Treatment.find(params[:video_id])
    @treatment.main_character ||=Character.new(:id=>@treatment.id)
  end
  
  def update
    @treatment=Treatment.find(params[:id])
    if @treatment.update_attributes(params[:treatment])
      redirect_to :back
    else
      puts "Das klappt nich mit den update"
    end
    
  end

  def create
  end
end
