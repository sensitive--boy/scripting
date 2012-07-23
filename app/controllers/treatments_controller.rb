class TreatmentsController < ApplicationController
    
  def new
  end

  def edit
    @treatment=Treatment.find_by_video_id(params[:video_id])
    @treatment.main_character ||=Character.new(:id=>@treatment.id)
    @treatment.characters.build if @treatment.characters.empty?
  end
  
  def update
    @treatment=Treatment.find(params[:id])
    @treatment.updated_by=current_user.person.name
    if @treatment.update_attributes(params[:treatment])
      redirect_to edit_video_path(@treatment.video)
    else
      puts "Das klappt nich mit den update"
    end
    
  end

  def create
  end
end
