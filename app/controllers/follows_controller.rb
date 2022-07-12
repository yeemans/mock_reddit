class FollowsController < ApplicationController
  def create 
    unless already_followed?(params[:follower_id], current_user.id)
      @following = Follow.create({:followed_user_id => params[:followed_user_id], :follower_id => current_user.id})
    end 

    respond_to do |format| 
      format.html { redirect_back fallback_location: root_path }
      format.js { }    
    end
  end

  private 
  def already_followed?(follower_id, followed_user_id)
    @follow = Follow.where(:follower_id => follower_id, :followed_user_id => followed_user_id)
    return !@follow.empty?
  end
end
