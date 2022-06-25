class PostsController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery except: :upvote

  respond_to :html, :js 
  
  def new 
    @post = Post.new
    @subreddits = Subreddit.all
  end 

  def create  
    @post = current_user.posts.build(post_params) # bind post to user
    @post.subreddit_id = params[:post][:subreddit] # bind post to subreddit 
    
    @post.body = params[:post][:content]

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
  
  def upvote
    @already_liked = Liking.where(liking_params)

    if @already_liked.empty?
      @liking = Liking.create(liking_params)  
    else 
      @already_liked.first.destroy
    end

    respond_to do |format| 
      format.html { redirect_to "#{root_path}#upvote-count-#{params[:id]}" }
      format.js {  }
    end

  end

  def liking_params
    params.permit(:id)
    params.require(:liking).permit(:user_id, :post_id, :is_upvote)
  end

end
