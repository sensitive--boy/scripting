class ShowsController < ApplicationController
  
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
  end

  def edit
    @show=Show.find(params[:id])
  end
end