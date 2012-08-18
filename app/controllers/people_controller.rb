class PeopleController < ApplicationController
  before_filter :authenticate_user!
  def index
    @people=Person.where("name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json{render :json=>@people.map(&:attributes)}
    end
  end
    
  def show
    @person=Person.find(params[:id])
  end
  
  def new
    new_person()
  end
  
  def edit
    @person=Person.find(params[:id])
    @person.address ||= Address.new(:id=>@person.id)
    puts "Ich, person#edit, habe adresse erzeugt"
  end
  
  def create
    new_person(params[:person])
    if @person.save
      redirect_to :back
    else
      render :action=>:edit
    end
  end
  
  def update
    @person=Person.find(params[:id])
    if @person.update_attributes(params[:person])
       redirect_to videos_showmy_path
    else
       render :action => 'edit'
    end
  end
  
  
  protected
  
  def new_person(attrs={})
    @person = Person.new(attrs)
    @person.address ||= Address.new(:id=>@person.id)
  end
end
