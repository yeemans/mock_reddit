class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:new, :create, :login, :logout]

  def index 

  end 
  
  def feed
    redirect_to new_user_session_path unless current_user 
    @subreddits = current_user.subreddits 
    @feed_posts = []
    @subreddits.each { |sub| @feed_posts += sub.posts.last(10) }
  end

  def profile 
    @profile_owner = User.find_by(username: params[:name])

    @avatar = get_avatar(@profile_owner)

    @profile_banner = 'default.png'
    @profile_banner = url_for(@profile_owner.banner) if @profile_owner.banner.persisted?

    @is_profile_owner = @profile_owner == current_user
  end

  def edit_profile 
    @user = current_user
  end

  def update 
    current_user.avatar.attach(params[:avatar]) if params[:avatar]
    current_user.banner.attach(params[:banner]) if params[:banner]
    redirect_to profile_path({ :name => current_user.username })
  end 

  def edit_bio 
    return unless User.find(current_user.id) == User.find(params[:user])
    @user = current_user
    @user.bio = params[:bio]
    @user.save!
    redirect_to profile_path(current_user.username)
  end

  def chat 
    @sender = User.find(params[:sender])
    @receiver = User.find(params[:receiver])
    @room = Room.new
    @message = Message.new
    @room_name = get_name(@sender, @receiver)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@sender, @receiver], @room_name)
    @messages = @single_room.messages
  end 

  def messages 
    @chats = get_private_chats(current_user)
    @receivers = []
    @chats.each { |chat| @receivers.append( get_receiver(chat) ) }
  end

  private
  def get_name(user1, user2)
    users = [user1, user2].sort
    return "private_#{users[0].id}_#{users[1].id}"
  end

  def get_private_chats(user)
    @rooms = Room.where(is_private: true)
    @rooms_with_user = []

    @rooms.each do |r| 
      @participants = [User.find( r.participants[0].user_id ), User.find( r.participants[1].user_id ) ]
      @rooms_with_user.append(r) if @participants.include?(user)
    end

    return @rooms_with_user
  end

  def get_receiver(room)
    @participants = room.participants
    talking_to_self = @participants[0].user_id == @participants[1].user_id
    return User.find(@participants[0].user_id) if talking_to_self
    @participants.each {|p| return User.find(p.user_id) if p.user_id != current_user.id }
    
  end
   
end
