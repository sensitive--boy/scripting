class AudiotracksController < ApplicationController
  before_filter :authenticate_user!
  def index
    @audiotracks = Audiotrack.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audiotracks }
    end
  end


  def show
    @audiotrack = Audiotrack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @audiotrack }
    end
  end


  def new
    @audiotrack = Audiotrack.new(:szene_id => params[:szene_id])
    puts params[:szene_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @audiotrack }
    end
  end


  def edit
    @audiotrack = Audiotrack.find(params[:id])
  end


  def create
    @audiotrack = Audiotrack.new(params[:audiotrack])
    @audiotrack.szene=Szene.find(params[:audiotrack][:szene_id])
    respond_to do |format|
      if @audiotrack.save
        format.html { redirect_to edit_szene_path(:id => @audiotrack.szene.id), notice: 'Audiotrack was successfully created.' }
        format.json { render json: @audiotrack, status: :created, location: @audiotrack }
      else
        format.html { render action: "new" }
        format.json { render json: @audiotrack.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @audiotrack = Audiotrack.find(params[:id])

    respond_to do |format|
      if @audiotrack.update_attributes(params[:audiotrack])
        format.html { redirect_to @audiotrack, notice: 'Audiotrack was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @audiotrack.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @audiotrack = Audiotrack.find(params[:id])
    @info.destroy

    respond_to do |format|
      format.html { redirect_to infos_url }
      format.json { head :no_content }
    end
  end
end
