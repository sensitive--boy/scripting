class RolesController < ApplicationController
  before_filter :authenticate_user!
  autocomplete :person, :name, :full => true
  
  def new
    @role = Role.new(:video_id => params[:video_id])
    session[:last_page] = request.env['HTTP_REFERER'] || videos_showmy_path
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role}
    end
  end
  
  def create
    @role = Role.new(:role => params[:role][:role], :person => Person.find_by_name(params[:role][:person]), :video_id => params[:role][:video_id])

    respond_to do |format|
      if @role.save
        format.html { redirect_to(edit_video_path(:id => @role.video_id), :notice => 'Role was successfully updated.')  }
        format.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @role = Role.find(params[:id])
  end
  
  def update
    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to(edit_video_path(:id => @role.video_id), :notice => 'Role was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(edit_video_path(:id => @role.video_id)) }
      format.xml  { head :ok }
    end
  end
end