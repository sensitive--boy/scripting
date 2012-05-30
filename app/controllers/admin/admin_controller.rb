class Admin::AdminController < ActionController::Base
  protect_from_forgery
  
  layout 'application'
  
  def administrate
    @admin=current_admin
  end
  
  def administrate_users
    @users=User.all
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
    @user.destroy
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
