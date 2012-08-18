class MediaFilesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @media_files = MediaFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media_files }
    end
  end


  def show
    @media_file = MediaFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @media_file }
    end
  end


  def new
    @media_file = MediaFile.new(:szene_id => params[:szene_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @media_file }
    end
  end


  def edit
    @media_file = MediaFile.find(params[:id])
  end


  def create
    @media_file = MediaFile.new(params[:media_file])

    respond_to do |format|
      if @media_file.save
        format.html { redirect_to edit_szene_path(:id => @media_file.szene.id), notice: 'MediaFile was successfully created.' }
        format.json { render json: @media_file, status: :created, location: @media_file }
      else
        format.html { render action: "new" }
        format.json { render json: @media_file.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @media_file = MediaFile.find(params[:id])

    respond_to do |format|
      if @media_file.update_attributes(params[:media_file])
        format.html { redirect_to @media_file, notice: 'MediaFile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @media_file.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @media_file = MediaFile.find(params[:id])
    @media_file.destroy

    respond_to do |format|
      format.html { redirect_to infos_url }
      format.json { head :no_content }
    end
  end
end
