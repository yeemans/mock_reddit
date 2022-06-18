class SubredditsController < ApplicationController
  def new 
    @subreddit = Subreddit.new
  end 

  def create 
    @subreddit = Subreddit.create(subreddit_params)
    @moderation = SubredditModeration.create({:moderator_id => current_user.id, 
    :moderated_subreddit_id => @subreddit.id})
    # create a room for this new sub 
    @room = Room.create( { :name => "#{@subreddit.title}_room" } )
    redirect_to r_path(@subreddit.title)
  end 

  def subreddit_params
    params.require(:subreddit).permit(:title, :banner)
  end

  def show 
    @subreddit = Subreddit.find_by(title: params[:title])
    @posts = @subreddit.posts
    @subscribed = current_user.subreddits.include?(@subreddit)
    @moderators = @subreddit.moderators

    @banner = get_banner(@subreddit)

    @room = Room.find_by(name: "#{@subreddit.title}_room")
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
    @results = PgSearch.multisearch(params[:query])

    @subreddit_results = @results.select { |r| r.searchable_type == "Subreddit" }
    @post_results = @results.select { |r| r.searchable_type == "Post" }
    @user_results = @results.select { |r| r.searchable_type == "User" }

    @subreddits = PostsHelper.objects_from_results(@subreddit_results)
    @posts = PostsHelper.objects_from_results(@post_results)
    @users = PostsHelper.objects_from_results(@user_results)

    ActiveStorage::Current.host = "https://mock-reddit-on-rails.herokuapp.com"  # change for testing and prod
  end

  def update 
    @subreddit = Subreddit.find_by(:title => params[:title])
    @subreddit.banner.attach(params[:subreddit][:banner]) 
    @subreddit.save!
    redirect_to r_path(@subreddit.title)
  end

  
end
