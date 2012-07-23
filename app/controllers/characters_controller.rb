class CharactersController < ApplicationController
  autocomplete :person, :name, :full=>true
  
  def create
    @character = Character.new(:charactername => params[:character][:charactername], :person => Person.find_by_name(params[:character][:person]), :video_id => params[:treatment][:video_id])

    respond_to do |format|
      if @role.save
        format.html { redirect_to(edit_video_path(:id => @character.treatment.video_id), :notice => 'Character was successfully updated.')  }
        format.xml  { render :xml => @character, :status => :created, :location => @character }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end
end
