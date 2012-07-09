class VideosController < ApplicationController
  autocomplete :person, :name, :full => true
  def new
    @video=Video.new
    @video.user=current_user
  end

  def edit
    @video = Video.find(params[:id])
    @video.treatment ||= Treatment.new(:id=>@video.id)
    @video.roles.build if @video.roles.empty?
    puts "edit"
    puts @video.roles.count
    @people=Person.all.map {|p| [p.name, p.id]}
    puts @people.count
  end
  
  def update
    @video = Video.find(params[:id])
    puts "update"
    puts @video.people.count
    @video.roles.each do
      
    @role = Role.create(:role=>params[:video][:roles_attributes][:id][:role], :person_id=>params[:video][:roles_attributes][:id][:person_id])
    end
    #if @video.update_attributes(params[:video])
     # redirect_to videos_showmy_path
    #else
      render :action => :edit
   # end
  end

  def show
    @video = Video.find(params[:id])
    @title=@video.title
  end

  def showmy
    @videos=current_user.videos
    @people=Person.all.map {|p| [p.name, p.id]}
    @shows=current_user.shows
  end

  def index
    @videos=Video.search(params[:search]).paginate(:per_page => 5, :page => params[:page])
  end
  
  def create
    @video = Video.new(params[:video])
    @video.user=current_user
    build_script(@video)
    if @video.save
      @title=@video.title
      puts 'save: %1$s' % [@title]
      redirect_to videos_showmy_path(@video.user)
    else
      render :action => "new"
    end
  end
  
  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to :back
  end
  
  def script
    @video = Video.find(params[:id])
  end
  
  def add_role
    @video = Video.find(params[:id])
    @role=Role.new(:video_id=>@video.id)
    @video.roles<<@role
    
    respond_to do |format|
      format.html {render :edit}
      format.js {render :patial=>'person_fields', :locals=>{:role=>@role}, :content_type => 'text/html' }
    end                
  end
  
  private
  def build_script(video)
    seq=Sequence.create(:video_id=>@video.id, :name=>'Sequence 1')
    @video.sequences << seq
    szene=Szene.create(:sequence_id=>seq.id, :title=>'Example Szene', :place=>"Am Flussufer, zwischen grossen Baeumen", :description=>"Person sitzt am Ufer, schaut in den Fluss und kaut einen Grashalm.")
    szene.insert_at
    take=Take.create(:szene_id=>szene.id, :view_desc=>"Totale, Flussufer mit hohen Baeumen", :audio_desc=>"Vogelzwischern, Wasserrauschen, Blaetterrascheln", :duration=>3000, :note=>"Person befindet sich bereits im Bild, ist jedoch kaum zu sehen.")
    take.insert_at
    @video.treatment=Treatment.new(:video_id=>@video.id)
  end
end
