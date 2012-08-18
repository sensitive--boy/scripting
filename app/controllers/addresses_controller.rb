class AddressesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @addresses=Addresses.all
  end
  
  def show
    @address = Address.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @address }
    end
  end
    
  def new
    @address=Address.new
    session[:last_page] = request.env['HTTP_REFERER'] || videos_showmy_path
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @address}
    end
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def create
    @address = Address.new(params[:address])
    respond_to do |format|
      if @address.save
        format.html { (session[:last_page]) ? (redirect_to session[:last_page]) : (render 'show')}
        format.xml  { render :xml => @address, :status => :created, :location => @address }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @address.errors, :status => :unprocessable_entity }
      end
    end
  end
  
 def update
    @address = Address.find(params[:id])
    respond_to do |format|
      if @address.update_attributes(params[:address])
        format.html { redirect_to :back, :notice => 'Take was successfully updated.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @address.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
end
