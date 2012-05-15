class ApplicationController < ActionController::Base
  protect_from_forgery

  def personalize
    if signed_in? && current_user.person!=nil
      redirect_to videos_showmy_path
    else      
      @user=current_user
      @user.person=Person.new(:email=>@user.email, :id=>@user.id)     
      redirect_to edit_person_path(@user.person)
    end
  end
end
