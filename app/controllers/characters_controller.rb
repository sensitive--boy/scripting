class CharactersController < ApplicationController
  before_filter :authenticate_user!
  autocomplete :person, :name, :full=>true
  
  def create
    @character = Character.new(:charactername => params[:character][:charactername], :person => Person.find_by_name(params[:character][:person_id]), :treatment_id => params[:character][:treatment_id])
    puts "Character create person"
    puts params[:character][:person]

    respond_to do |format|
      if @character.save
        format.html { redirect_to(session[:last_page], :notice => 'Character was successfully updated.')  }
        format.xml  { render :xml => @character, :status => :created, :location => @character }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def new
    @character = Character.new(:treatment_id => params[:treatment_id])
    session[:last_page] = request.env['HTTP_REFERER'] || edit_treatment_path(@character.treatment)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @character}
    end
  end
  
  
  def edit
    @character = Character.find(params[:id])
  end
  
  def update
    @character = Character.find(params[:id])

    respond_to do |format|
      if @character.update_attributes(params[:character])
        format.html { redirect_to(edit_video_path(:id => @character.treatment_id), :notice => 'Character was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @character = Character.find(params[:id])
    @character.destroy

    respond_to do |format|
      format.html { redirect_to(edit_video_path(:id => @character.treatment_id)) }
      format.xml  { head :ok }
    end
  end
end
