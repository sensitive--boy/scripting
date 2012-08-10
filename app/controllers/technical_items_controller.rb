class TechnicalItemsController < ApplicationController
  def index
    @technical_items = TechnicalItem.paginate :page => params[:page], :per_page => 3, :order => 'name ASC'
  end
  
  def new
    @technical_item = TechnicalItem.new
  end
  
  def create
    @technical_item = TechnicalItem.new(params[:technical_item])
    if @technical_item.save
      redirect_to technical_items_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @technical_item = TechnicalItem.find(params[:id])
  end
  
  def update
    @technical_item = TechnicalItem.find(params[:id])
    if @technical_item.update_attributes(params[:technical_item])
      redirect_to technical_items_path
    else
      render :action => "edit"
    end
  end
  
  def show
    @technical_item = TechnicalItem.find(params[:id])
  end
  
  def destroy
    @technical_item = TechnicalItem.find(params[:id])
    @technical_item.destroy
    redirect_to technical_items_path
  end
end
