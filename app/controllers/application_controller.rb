class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_application_variables

  helper_method :signed_in_user 
  helper_method :get_avatar
  helper_method :get_banner

  helper_method :get_upvote_count
  helper_method :get_comment_upvote_count

  helper_method :get_liked_posts 
  helper_method :has_liked_post

  helper_method :get_liked_comments 
  helper_method :has_liked_comment
  helper_method :has_disliked_comment
  
  helper_method :has_disliked_post
  helper_method :get_opposite_liking
  helper_method :already_followed?

  def signed_in_user
    return current_user 
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :password, :email, :remember_me) }
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :email, :first_name, :last_name, :password, :password_confirmation, :email) }
  end

  def set_application_variables
    @avatar = "default.png"
    @signed_in = current_user 
    @has_avatar = current_user.avatar.persisted? if @signed_in
    @avatar = url_for(current_user.avatar) if @signed_in && @has_avatar 
  end

  protected 

  def get_avatar(user)
    return url_for(user.avatar) if user.avatar.persisted?
    return user.omniauth_pfp if user.omniauth_pfp
    return 'default.png'
  end

  def get_banner(subreddit)
    banner = ActionController::Base.helpers.image_url('default_banner.png')
    banner = url_for(subreddit.banner) if subreddit.banner.persisted? 
    return banner
  end

  def get_upvote_count(post)
    upvotes = post.likings.where(:is_upvote => true).count
    downvotes = post.likings.where(:is_upvote => false).count
    return upvotes - downvotes
  end

  def get_comment_upvote_count(comment)
    upvotes = comment.comment_likings.where(:is_upvote => true).count
    downvotes = comment.comment_likings.where(:is_upvote => false).count
    return upvotes - downvotes
  end

  def get_liked_posts(user)
    liked_posts = []

    user.likings.each do |liking| 
      liked_posts.push(Post.find(liking.post_id)) if liking.is_upvote 
    end

    return liked_posts
  end

  def get_liked_comments(user)
    liked_comments = []

    user.comment_likings.each do |liking| 
      liked_comments.push(Comment.find(liking.comment_id)) if liking.is_upvote 
    end

    return liked_comments
  end

  def has_liked_post(user, post)
    liked_posts = get_liked_posts(user)
    return liked_posts.include?(post)
  end

  def has_disliked_post(user, post)
    dislikes = user.likings.where(:is_upvote => false)

    dislikes.each do |dislike| 
      return true if dislike.post_id == post.id
    end

    return false
  end

  def has_liked_comment(user, comment)
    liked_comments = get_liked_comments(user)
    return liked_comments.include?(comment)
  end

  def has_disliked_comment(user, comment)

    user.comment_likings.each do |liking| 
      return true if liking.comment_id == comment.id && liking.is_upvote == false 
    end

    return false
  end

  def get_opposite_liking(user, liking)
    if liking.is_upvote
      liking_params = { :user_id => liking.user_id, :post_id => liking.post_id, :is_upvote => false }
    else
      liking_params = { :user_id => liking.user_id, :post_id => liking.post_id, :is_upvote => true }
    end 

    return Liking.where(liking_params)
  end

  def get_opposite_comment_liking(user, liking)
    if liking.is_upvote
      liking_params = { :user_id => liking.user_id, :comment_id => liking.comment_id, :is_upvote => false }
    else
      liking_params = { :user_id => liking.user_id, :comment_id => liking.comment_id, :is_upvote => true }
    end 

    return CommentLiking.where(liking_params)
  end

  def already_followed?(follower_id, followed_user_id)
    @follow = Follow.where(:follower_id => follower_id, :followed_user_id => followed_user_id)
    return !@follow.empty?
  end

end
