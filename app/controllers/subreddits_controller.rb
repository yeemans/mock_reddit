class SubredditsController < ApplicationController
  def new 
    @subreddit = Subreddit.new
  end 

  def create 
    @subreddit = Subreddit.create(subreddit_params)
    @moderation = SubredditModeration.create({:moderator_id => current_user.id, 
    :moderated_subreddit_id => @subreddit.id})
  end 

  def subreddit_params
    params.require(:subreddit).permit(:title, :banner_link)
  end

  def show 
    @subreddit = Subreddit.find_by(title: params[:title])
    @posts = @subreddit.posts
    @subscribed = current_user.subreddits.include?(@subreddit)
    @banner = 'default_banner'
    @banner = @subreddit.banner_link if @subreddit.banner_link != ""
  end

  def subscribe 
    @subreddit = Subreddit.find_by(title: params[:title])
    @subscription = Subscription.new({ :user => current_user, :subreddit => @subreddit })
    @subscription.save! unless current_user.subreddits.include?(@subreddit)
  end 

  def unsubscribe 
    @subreddit = Subreddit.find_by(title: params[:title])
    return unless current_user.subreddits.include?(@subreddit)
    Subscription.where(user: current_user, subreddit: @subreddit.id).first.destroy
  end

  def search 
    
  end

end
