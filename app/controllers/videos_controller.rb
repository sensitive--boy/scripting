class VideosController < ApplicationController
  def new
    @video=Video.new
    @video.user=current_user
  end

  def edit
  end

  def show
    @video = Video.find(params[:id])
    @title=@video.title
  end

  def showmy
    @videos=current_user.videos
    @shows=current_user.shows
  end

  def index
    @videos=Video.all
  end
  
  def create
    @video = Video.new(params[:video])
    @video.user=current_user
    if @video.save
      @title=@video.title
      puts 'save: %1$s' % [@title]
      redirect_to @video
    else
      render :action => "new"
    end
  end
end
