class TakesController < ApplicationController

  def index
    @takes = Takes.all
     #@takes = Take.where(:video => ), :group => :address)
   end

   # GET /takes/1
   # GET /takes/1.xml
  def show
    @take = Take.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @take }
    end
  end
  
   # GET /takes/new
   # GET /takes/new.xml
  def new
    @take = Take.new(:szene => Szene.find(params[:szene_id]))
    @addresses=Address.all.map {|a| [a.address, a.city, a.id]}
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @take}
    end
  end

   # GET /takes/1/edit
  def edit
    @take = Take.find(params[:id])
    @addresses=Address.all.map {|a| [a.address, a.city, a.id]}
  end
  
   # POST /takes
   # POST /takes.xml
  def create
    @take = Take.new(params[:take])
    @take.address = Address.find(:id => params[:take][:address])

    respond_to do |format|
      if @take.save
        format.html { redirect_to(script_videos_path(:id => @take.szene.sequence.video.id), :notice => 'Take was successfully updated.') }
        format.xml  { render :xml => @take, :status => :created, :location => @take }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @take.errors, :status => :unprocessable_entity }
      end
    end
  end

   # change 'position' of take in szene after drag
  def sort
    @takes = Take.where(:id => params[:take])
    @takes.each do |take|
      take.position = params['take'].index(take.id.to_s)+1
      take.save
    end
    render :nothing => true
  end
  
  
   # PUT /takes/1
   # PUT /takes/1.xml
  def update
    @take = Take.find(params[:id])
    @take.address = Address.find_by_id(params[:take][:address])

    respond_to do |format|
      if @take.update_attributes(params[:take])
        format.html { redirect_to(script_videos_path(:id => @take.szene.sequence.video.id), :notice => 'Take was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @take.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /takes/1
  # DELETE /takes/1.xml
  def destroy
    @take = Take.find(params[:id])
    @take.destroy

    respond_to do |format|
      format.html { redirect_to(script_videos_path(:id => @take.szene.sequence.video.id)) }
      format.xml  { head :ok }
    end
  end
  
end
