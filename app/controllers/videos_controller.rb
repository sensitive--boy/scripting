class VideosController < ApplicationController
  autocomplete :person, :name, :full => true, :extra_data => [:user_id], :scopes => [:by_advisor]
  
  def new
    @video=Video.new
    @video.user=current_user
  end

  def edit
    @video = Video.find(params[:id])
    @video.duration+=@video.takes.sum(:duration)
    @video.treatment ||= Treatment.new(:video_id=>@video.id)
    @video.chosen_items = ChosenItem.where(:video_id => @video.id)
    @video.roles.build if @video.roles.empty?
  end
  
  def update
    @video = Video.find(params[:id])
    @video.advisor ||= User.find(params[:video][:advisor_id])
    @video.advisor.video_id=@video.id
    puts "update"
    puts params[:video][:advisor_id]
    puts @video.roles.count
    @video.roles.each do |role|
      role.update_attributes(:role => params[:role], :person => params[:person])
    end
    if @video.update_attributes(params[:video])
      render :action => :edit
    else
        puts @video.roles.count
      render :action => :edit
    end
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
    puts @allmyvideos.count
  end

  def index
    @videos=Video.search(params[:search]).paginate(:per_page => 5, :page => params[:page])
  end
  
  def create
    @video = Video.new(params[:video])
    @video.user=current_user
    @video.treatment=Treatment.new(:video_id=>@video.id)
    @video.duration=0
    @video.calculate_supposed_duration
    @video.build_script
    if @video.save
      @title=@video.title
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
      format.js {render :partial=>'person_fields', :locals=>{:role=>@role}, :content_type => 'text/html' }
    end                
  end
  
  def contacts
    @video = Video.find(params[:id])
    @crewpeople=[]
    @actors=[]
    @video.roles.each do |r|
      @crewpeople << r.person
    end
    @video.treatment.characters.each do |c|
      @actors << c.person
    end
    @contacts=(@crewpeople+@actors).uniq
    @contacts=@contacts.sort_by{|person| person.name}
  end
  
  def select_item
    @video = Video.find(params[:id])
    find_items
  end
  
  def choose_item
    @video = Video.find(params[:id])
    @item = ChosenItem.new(:video_id => @video.id, :technical_item_id => params[:item])
    @item.save
    @video.chosen_items << @item
    find_items
    render :action => 'select_item'
  end
  
  def discard_item
    @video = Video.find(params[:id])
    @video.chosen_items.destroy(params[:item])
    find_items
    render :action => 'select_item'
  end
  
  private
  def find_items
    @available_items = TechnicalItem.where('available' => true)
    @choosable_items = @available_items - @video.technical_items
  end
  
  def build_script
    @video.sequences.build
    seq=Sequence.create(:video_id=>@video.id, :name=>'Sequence 1')
    seq.insert_at
    szene=Szene.create(:sequence_id=>seq.id, :title=>'Example Szene', :place=>"Am Flussufer, zwischen grossen Baeumen", :description=>"Person sitzt am Ufer, schaut in den Fluss und kaut einen Grashalm.")
    szene.insert_at
    take=Take.create(:szene_id=>szene.id, :view_desc=>"Totale, Flussufer mit hohen Baeumen", :audio_desc=>"Vogelzwischern, Wasserrauschen, Blaetterrascheln", :duration=>30, :note=>"Person befindet sich bereits im Bild, ist jedoch kaum zu sehen.")
    take.insert_at
    @video.treatment=Treatment.new(:video_id=>@video.id)
  end
end
