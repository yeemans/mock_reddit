class UsersController < ApplicationController
  before_action :authenticate_user!

  def index 

  end 
  
  def feed
    redirect_to new_user_session_path unless current_user 
  end

  def show 

  end

  def profile 
    @profile_owner = User.find_by(username: params[:name])

    @avatar = 'default.png'
    @avatar = url_for(@profile_owner.avatar) if @profile_owner.avatar.persisted? 

    @profile_banner = 'default.png'
    @profile_banner = url_for(@profile_owner.banner) if @profile_owner.banner.persisted?

    @is_profile_owner = @profile_owner == current_user
  end

  def edit_profile 
    @user = current_user
  end

  def update 
    current_user.avatar.attach(params[:avatar]) if params[:avatar]
    current_user.banner.attach(params[:banner]) if params[:banner]
    #redirect_to profile_path({ :name => current_user.username })
  end 

end
