class VideosController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @videos=Video.search(params[:search]).paginate :page => params[:page], :order => 'created_at ASC', :per_page => 5
  end
  
  def new
    @video=Video.new
    @video.user=current_user
  end
  
  def create
    @video = Video.new(params[:video])
    @video.user=current_user
    @video.treatment=Treatment.new(:video_id=>@video.id)
    @video.duration=0
    @video.calculate_supposed_duration
    @video.build_script
    if @video.save
      redirect_to edit_video_path(@video)
    else
      render :action => "new"
    end
  end
  
  def edit
    @video=Video.find(params[:id])
    @video.duration+=@video.takes.sum(:duration)
    @video.treatment ||= Treatment.new(:video_id=>@video.id)
    @video.chosen_items = ChosenItem.where(:video_id => @video.id)
    @video.roles.build if @video.roles.empty?
  end
  
  def update
    @video=Video.find(params[:id])
    
    if @video.advisor.nil? && ((params[:video][:advisor_id]) != "")
      @video.advisor = User.find(params[:video][:advisor_id])
      @video.propose!
      VideoMailer.new_video_mail(@video).deliver
    end
    if @video.update_attributes(params[:video])
      redirect_to edit_video_path(@video)
    else
      render :action => :edit
    end
  end

  def show
    @video=Video.find(params[:id])
  end
  
  def destroy
    @video=Video.find(params[:id])
    @video.destroy
    redirect_to videos_showmy_path(@video.user)
  end
  
  def showmy
    @videos=current_user.videos
    @shows=current_user.shows
    @other_videos=[]
    Role.where(:person_id => current_user.person.id).each do |role|
      @other_videos << role.video
    end
    @allmyvideos=(@videos+@other_videos).uniq
    
    @supervised=Video.where('advisor_id' => current_user.id)
  end
  
  def script
    @video=Video.find(params[:id])
  end
  
  def takelist
    @video=Video.find(params[:id])
    @takes_with_ad=[]
    @takes_without=[]
    @video.takes.each do |take|
      if take.address
	@takes_with_ad << take
      else
	@takes_without << take
      end
    end
  end
  
  def musiclist
    @video=Video.find(params[:id])
  end
  
  def contacts
    @video=Video.find(params[:id])
    @crewpeople=[]
    @actors=[]
    @video.roles.each do |r|
    if r.person
      @crewpeople << r.person
      end
    end
    @video.treatment.characters.each do |c|
    if c.person
      @actors << c.person
      end
    end
    @contacts=(@crewpeople+@actors).uniq
    @contacts=@contacts.sort_by{|person| person.name}
  end
  
  def select_item
    @video=Video.find(params[:id])
    find_items
  end
  
  def choose_item
    @video=Video.find(params[:id])
    @item = ChosenItem.new(:video_id => @video.id, :technical_item_id => params[:item])
    @item.save
    @video.chosen_items << @item
    find_items
    render :action => 'select_item'
  end
  
  def discard_item
    @video=Video.find(params[:id])
    @video.chosen_items.destroy(params[:item])
    find_items
    render :action => 'select_item'
  end
  
  def accept_idea
    @video=Video.find(params[:id])
    @video.accept_idea!
    redirect_to edit_video_path(@video)
  end
  
  def fin_treat
    @video=Video.find(params[:id])
    @video.finish_treatment!
    VideoMailer.changed_state_mail(@video).deliver
    redirect_to edit_video_path(@video)
  end
  
  def acc_treat
    @video=Video.find(params[:id])
    @video.accept_treatment!
    redirect_to edit_video_path(@video)
  end
  
  def fin_prod
    @video=Video.find(params[:id])
    @video.finish_production!
    VideoMailer.changed_state_mail(@video).deliver
    redirect_to edit_video_path(@video)
  end
  
  def acc_prod
    @video=Video.find(params[:id])
    @video.accept_production!
    redirect_to edit_video_path(@video)
  end
  
  def fin_vid
    @video=Video.find(params[:id])
    @video.finish_video!
    redirect_to edit_video_path(@video)
  end
  
  def arch_vid
    @video=Video.find(params[:id])
    @video.archivate!
    redirect_to edit_video_path(@video)
  end
  
  private
  def find_items
    @available_items = TechnicalItem.where('available' => true)
    @choosable_items = @available_items - @video.technical_items
  end
  
end
