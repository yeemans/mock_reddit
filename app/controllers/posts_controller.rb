class PostsController < ApplicationController

  def new 
    @post = Post.new
    @subreddits = Subreddit.all
  end 

  def create  
    @post = current_user.posts.build(post_params) # bind post to user
    @post.subreddit_id = params[:post][:subreddit] # bind post to subreddit 
    @post.save!
    flash[:post_success] = "Post created!" 
  end

  def post_params 
    params.require(:post).permit(:subreddit_id, :content, :title, :image)
  end

  def show 
    @post = Post.find(params[:id])
    @subreddit = Subreddit.find(@post.subreddit_id)
    @banner = 'default_banner'
    @banner = @subreddit.banner_link if @subreddit.banner_link != ""

  end
end
