class SequencesController < ApplicationController
  

  def index
    @sequences = Sequences.all
   end

   # GET /sequences/1
   # GET /sequences/1.xml
  def show
    @sequence = Sequence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sequence }
    end
  end
  
   # GET /sequences/new
   # GET /sequences/new.xml
  def new
    @sequence = Sequence.new(:video => Video.find(params[:video_id]))
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sequence}
    end
  end

   # GET /sequences/1/edit
  def edit
    @sequence = Sequence.find(params[:id])
  end
  
   # POST /sequences
   # POST /sequences.xml
  def create
    @sequence = Sequence.new(params[:sequence])
    @sequence.video= Video.find(params[:sequence][:video_id])
    puts "----- in der naechsten Zeile sollte der name des Videos stehen -----"
    puts @sequence.video.title
    puts params[:sequence][:name]
    respond_to do |format|
      if @sequence.save
        format.html {redirect_to(script_videos_path(:id=>@sequence.video_id), :notice => 'Sequence was successfully created.')}
        format.xml  { render :xml => @sequence, :status => :created, :location => @sequence }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sequence.errors, :status => :unprocessable_entity }
      end
    end
  end

   # change 'position' of szene in script after drag
  def sort
    @sequences = Sequence.where(:id => params[:sequence])
    @sequences.each do |sequence|
      sequence.position = params['sequence'].index(sequence.id.to_s)+1
      sequence.save
    end
    render :nothing => true
  end
  
#def sort
#@sequences = Sequence.all
#@sequences.each do |seq|
#seq.position = params['sequence'].index(seq.id.to_s) + 1
#seq.save
#end

#render :nothing => true
#end
  
  
   # PUT /sequences/1
   # PUT /sequences/1.xml
  def update
    @sequence = Sequence.find(params[:id])

    respond_to do |format|
      if @sequence.update_attributes(params[:sequence])
        format.html { redirect_to(script_videos_path(:id=>@sequence.video_id), :notice => 'Sequence was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sequences/1
  # DELETE /sequencess/1.xml
  def destroy
    @sequence = Sequence.find(params[:id])
    puts @sequence.video.title
    @video=@sequence.video
    @sequence.destroy

    respond_to do |format|
      format.html { redirect_to(script_videos_path(:id=>@sequence.video_id), :notice => 'Sequence deleted.') }
      format.js   { render :nothing => true }
      format.xml  { head :ok }
    end
  end

end
