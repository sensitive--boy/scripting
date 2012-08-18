class Admin::AdminController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_admin!
  layout 'application'
  
  def administrate
    @admin=current_admin
  end
  
  def administrate_users
    @users=User.paginate :page => params[:page], :order => 'created_at ASC', :per_page => 2
  end
  
  def make_advisor
    find_user
    @user.become_advisor
    show_all_users
  end
  
  def unmake_advisor
    find_user
    @user.normal_user
    show_all_users
  end
  
  def destroy_user
    find_user
    if @user.videos || @user.shows
      puts "es gibt noch Videos oder Sendungen!!"
    else
      
      @user.destroy
    end
    show_all_users
  end
  
  private
  
  def find_user
    @user=User.find(params[:id])
  end
  
  def show_all_users
    @users=User.all
    render :action=>'administrate_users'
  end
end
