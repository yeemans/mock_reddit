class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_application_variables

  helper_method :signed_in_user 
  helper_method :get_avatar
  helper_method :get_banner
  helper_method :get_upvote_count
  helper_method :get_liked_posts 
  helper_method :has_liked_post

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

  def get_liked_posts(user)
    liked_posts = []

    user.likings.each do |liking| 
      liked_posts.push(Post.find(liking.post_id))
    end

    return liked_posts
  end

  def has_liked_post(user, post)
    liked_posts = get_liked_posts(user)
    return liked_posts.include?(post)
  end

end
