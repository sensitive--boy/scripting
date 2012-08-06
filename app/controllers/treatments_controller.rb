class TreatmentsController < ApplicationController
    
  def new
    @treatment=Treatment.new
  end

  def edit
    @treatment=Treatment.find(params[:id])
    @treatment.main_character ||=Character.new(:treatment_id=>@treatment.id)
    @treatment.characters.build if @treatment.characters.empty?
    puts "edit Treatment Video"
    puts @treatment.id
    puts params[:video_id]
  end
  
  def update
    @treatment=Treatment.find(params[:id])
    @treatment.updated_by=current_user.person.name
    if params[:character]
      @treatment.main_character.update_attributes(:charactername => params[:character][:charactername], :person => Person.find_by_name(params[:character][:person_id]), :treatment_id => @treatment.id)
    end
    if @treatment.update_attributes(params[:treatment])
      redirect_to edit_video_path(@treatment.video)
    else
      puts "Das klappt nich mit den update"
    end
    
  end

  def create
    @treatment=Treatment.new(params[:treatment])
    puts "create Treatment"
    puts @treatment.id
  end
end
