class SerialsController < ApplicationController
  
  def index
    @video_serials = Serial.where(:for_shows == false)
    @show_serials = Serial.where(:for_shows == true)
  end
  
  def show
    @serial = Serial.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @serial }
    end
  end
  
  def new
    @serial = Serial.new
    if params[:for_shows]
      @serial.for_shows = true
    end
    session[:last_page] = request.env['HTTP_REFERER'] || videos_showmy_path
    puts session[:last_page]
    respond_to do |format|
      format.html  # new.html.erb
      format.xml  { render :xml => @serial}
    end
  end
  
  def create
    @serial = Serial.new(params[:serial])
    respond_to do |format|
      if @serial.save
        format.html { redirect_to(session[:last_page], :notice => 'Serial was successfully created.') }
        format.xml  { render :xml => @serial, :status => :created, :location => @serial }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @serial.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @serial = Serial.find(params[:id])
    session[:last_page] = request.env['HTTP_REFERER'] || videos_showmy_path
  end
  
  def update
    @serial = Serial.find(params[:id])
    respond_to do |format|
      if @serial.update_attributes(params[:serial])
        format.html { redirect_to(session[:last_page], :notice => 'Szene was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @serial.errors, :status => :unprocessable_entity }
      end
    end
  end
end
