class PostsController < ApplicationController
  before_action :authenticate_user!
  def new 
    @post = Post.new
    @subreddits = Subreddit.all
  end 

  def create  
    @post = current_user.posts.build(post_params) # bind post to user
    @post.subreddit_id = params[:post][:subreddit] # bind post to subreddit 
    
    @post.body = params[:post][:content]
    @post.upvotes = 0
    @post.save!

    flash[:post_success] = "Post created!" 
    redirect_to post_path(@post.id)
  end

  def post_params 
    params.require(:post).permit(:subreddit_id, :content, :title, :image)
  end

  def show 
    @post = Post.find(params[:id])
    @subreddit = Subreddit.find(@post.subreddit_id)

    @banner = get_banner(@subreddit)

    @moderators = @subreddit.moderators
    @comment = Comment.new
    @comments = @post.comments
  end

end
