class VideosController < ApplicationController
  autocomplete :person, :name, :full => true, :extra_data => [:user_id], :scopes => [:by_advisor]
  
  def new
    @video=Video.new
    @video.user=current_user
  end

  def edit
    find_video
    @video.duration+=@video.takes.sum(:duration)
    @video.treatment ||= Treatment.new(:video_id=>@video.id)
    @video.chosen_items = ChosenItem.where(:video_id => @video.id)
    @video.roles.build if @video.roles.empty?
  end
  
  def update
    find_video
    if @video.advisor.nil? && params[:video][:advisor_id]
      @video.advisor = User.find(params[:video][:advisor_id])
      @video.propose!
      VideoMailer.new_video_mail(@video).deliver
    end

    if @video.update_attributes(params[:video])
      render :action => :edit
    else
      render :action => :edit
    end
  end

  def show
    find_video
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
    
    @supervised=Video.where('advisor_id' => current_user.id)
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
      redirect_to edit_video_path(@video)
    else
      render :action => "new"
    end
  end
  
  def destroy
    find_video
    @video.destroy
    redirect_to videos_showmy_path(@video.user)
  end
  
  def script
    find_video
  end
  
  def add_role
    find_video
    @role=Role.new(:video_id=>@video.id)
    @video.roles<<@role
    
    respond_to do |format|
      format.html {render :edit}
      format.js {render :partial=>'person_fields', :locals=>{:role=>@role}, :content_type => 'text/html' }
    end                
  end
  
  def contacts
    find_video
    @crewpeople=[]
    @actors=[]
    @video.roles.each do |r|
    if r.person
      @crewpeople << r.person
      puts r.person.name
      end
    end
    puts @video.roles.count
    @video.treatment.characters.each do |c|
    if c.person
      @actors << c.person
      puts c.person.name
      end
    end
    puts @video.treatment.characters.count
    @contacts=(@crewpeople+@actors).uniq
    puts @contacts.count
   # @contacts=@contacts.sort_by{|person| person.name}
  end
  
  def select_item
    find_video
    find_items
  end
  
  def choose_item
    find_video
    @item = ChosenItem.new(:video_id => @video.id, :technical_item_id => params[:item])
    @item.save
    @video.chosen_items << @item
    find_items
    render :action => 'select_item'
  end
  
  def discard_item
    find_video
    @video.chosen_items.destroy(params[:item])
    find_items
    render :action => 'select_item'
  end
  
  def accept_idea
    find_video
    @video.accept_idea!
    redirect_to edit_video_path(@video)
  end
  
  def fin_treat
    find_video
    @video.finish_treatment!
    redirect_to edit_video_path(@video)
  end
  
  def acc_treat
    find_video
    @video.accept_treatment!
    redirect_to edit_video_path(@video)
  end
  
  def fin_prod
    find_video
    @video.finish_production!
    redirect_to edit_video_path(@video)
  end
  
  def acc_prod
    find_video
    @video.accept_production!
    redirect_to edit_video_path(@video)
  end
  
  def fin_vid
    find_video
    @video.finish_video!
    redirect_to edit_video_path(@video)
  end
  
  def arch_vid
    find_video
    @video.archivate!
    redirect_to edit_video_path(@video)
  end
  
  private
  def find_video
    @video=Video.find(params[:id])
  end
  
  def find_items
    @available_items = TechnicalItem.where('available' => true)
    @choosable_items = @available_items - @video.technical_items
  end
  
end
