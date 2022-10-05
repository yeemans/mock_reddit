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
    @comments = @post.comments.where(parent_id: nil)
  end
  
  def upvote
    @opposite_liking = get_opposite_liking(current_user, Liking.new(liking_params)).first

    @opposite_liking.destroy if @opposite_liking

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

  def delete 
    @post = Post.find(params[:post_id])
    @subreddit = Subreddit.find(@post.subreddit_id)

    @liking = Liking.where(:post_id => params[:post_id])
    @liking.each do |liking| 
      liking.delete
    end

    @post.delete 
    # also delete the search doc
    PgSearch::Document.find_by(:searchable_type => "Post", :searchable_id => params[:post_id]).delete 
    flash[:deleted] = "Post deleted"
    redirect_to r_path(@subreddit.title)
  end

  private


end
