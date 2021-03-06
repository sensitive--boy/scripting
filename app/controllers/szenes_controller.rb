class SzenesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @szenes = Szenes.all
   end

   # GET /szenes/1
   # GET /szenes/1.xml
  def show
    @szene = Szene.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @szene }
    end
  end
  
   # GET /szenes/new
   # GET /szenes/new.xml
  def new
    @szene = Szene.new(:sequence_id => (params[:sequence_id]))
    respond_to do |format|
      format.html  # new.html.erb
      format.xml  { render :xml => @szene}
    end
  end

   # GET /szenes/1/edit
  def edit
    @szene = Szene.find(params[:id])
  end
  
   # POST /szenes
   # POST /szenes.xml
  def create
    @szene = Szene.new(params[:szene])
    @szene.sequence = Sequence.find(params[:szene][:sequence_id])
    @szene.sequence.name
    respond_to do |format|
      if @szene.save
        format.html { redirect_to(script_video_path(:id => @szene.sequence.video.id), :notice => 'Szene was successfully created.') }
        format.xml  { render :xml => @szene, :status => :created, :location => @szene }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @szene.errors, :status => :unprocessable_entity }
      end
    end
  end

   # change 'position' of szene in script after drag
  def sort
    @szenes = Szene.where(:id => params[:szene])
    @szenes.each do |szene|
      szene.position = params['szene'].index(szene.id.to_s)+1
      szene.save
    end
    render :nothing => true
  end
  
  
   # PUT /szenes/1
   # PUT /szenes/1.xml
  def update
    @szene = Szene.find(params[:id])

    respond_to do |format|
      if @szene.update_attributes(params[:szene])
        format.html { redirect_to(script_video_path(:id => @szene.sequence.video.id), :notice => 'Szene was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @szene.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /szenes/1
  # DELETE /szenes/1.xml
  def destroy
    @szene = Szene.find(params[:id])
    @szene.destroy

    respond_to do |format|
      format.html { redirect_to(script_video_path(:id => @szene.sequence.video.id)) }
      format.xml  { head :ok }
    end
  end

end
