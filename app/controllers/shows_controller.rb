class ShowsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @shows=Show.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
  end

  def new
    @show=Show.new
    @show.user=current_user
    puts "Shows#new created a show from:"
    puts @show.user.person.name
    @person=@show.user.person
  end

  def create
    @show=Show.new(params[:show])
    @show.user=current_user
    puts params[:show]
    if @show.save!
      redirect_to videos_showmy_path
    else
      render :action=>new
    end
  end

  def show
    @show=Show.find(params[:id])
  end

  def edit
    @show=Show.find(params[:id])
  end
  
   # PUT /shows/1
   # PUT /shows/1.xml
  def update
    @show = Show.find(params[:id])

    respond_to do |format|
      if @show.update_attributes(params[:show])
        format.html { redirect_to(videos_showmy_path, :notice => 'Show was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @show.errors, :status => :unprocessable_entity }
      end
    end
  end
end
