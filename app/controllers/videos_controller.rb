class VideosController < ApplicationController
  autocomplete :person, :name, :full => true, :extra_data => [:user_id], :scopes => [:by_advisor]
  
  def new
    @video=Video.new
    @video.user=current_user
  end

  def edit
    @video = Video.find(params[:id])
    @video.treatment ||= Treatment.new(:video_id=>@video.id)
    @video.roles.build if @video.roles.empty?
    puts "edit"
    puts @video.roles.count
  end
  
  def update
    @video = Video.find(params[:id])
    puts "update"
    puts @video.people.count
    puts @video.roles.count
    @video.roles.each do |role|
      role.update_attributes(:role => params[:role], :person => params[:person])
    end
    #if @video.update_attributes(params[:video])
     # redirect_to videos_showmy_path
    #else
        puts @video.roles.count
      render :action => :edit
   # end
  end

  def show
    @video = Video.find(params[:id])
    @title=@video.title
  end

  def showmy
    @videos=current_user.videos
    @shows=current_user.shows
    @other_videos=[]
    Role.where(:person_id => current_user.person.id).each do |role|
      @other_videos << role.video
    end
    @allmyvideos=(@videos+@other_videos).uniq
    puts @videos.count
    puts "+"
    puts @other_videos.count
    puts "="
    puts @allmyvideos.count
  end

  def index
    @videos=Video.search(params[:search]).paginate(:per_page => 5, :page => params[:page])
  end
  
  def create
    @video = Video.new(params[:video])
    @video.user=current_user
    @video.treatment=Treatment.new(:video_id=>@video.id)
    @video.build_script
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
    redirect_to videos_showmy_path(@video.user)
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
  def build_script
    @video.sequences.build
    seq=Sequence.create(:video_id=>@video.id, :name=>'Sequence 1')
    seq.insert_at
    szene=Szene.create(:sequence_id=>seq.id, :title=>'Example Szene', :place=>"Am Flussufer, zwischen grossen Baeumen", :description=>"Person sitzt am Ufer, schaut in den Fluss und kaut einen Grashalm.")
    szene.insert_at
    take=Take.create(:szene_id=>szene.id, :view_desc=>"Totale, Flussufer mit hohen Baeumen", :audio_desc=>"Vogelzwischern, Wasserrauschen, Blaetterrascheln", :duration=>3000, :note=>"Person befindet sich bereits im Bild, ist jedoch kaum zu sehen.")
    take.insert_at
    @video.treatment=Treatment.new(:video_id=>@video.id)
  end
end
