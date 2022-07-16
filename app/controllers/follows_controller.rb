class FollowsController < ApplicationController
  def create 
    @profile_owner = User.find(params[:followed_user_id])
    @message = "Already Followed"


    respond_to do |format| 
      format.html { redirect_to profile_path(@profile_owner.username) }
      format.js { }    
    end 

    if already_followed?(current_user.id, params[:followed_user_id])
      @follow = Follow.where(:followed_user_id => params[:followed_user_id], 
                                    :follower_id => current_user.id)
      @follow.first.delete
      return
    end

    unless already_followed?(current_user.id, params[:followed_user_id])
      @following = Follow.create({:followed_user_id => params[:followed_user_id], :follower_id => current_user.id})
      @message = "You are now following #{@profile_owner.username}."
    end

  end

end
