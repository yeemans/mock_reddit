class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:new, :create, :login, :logout]

  def index 

  end 
  
  def feed
    redirect_to new_user_session_path unless current_user 
  end

  def profile 
    @profile_owner = User.find_by(username: params[:name])

    @avatar = 'default.png'
    @avatar = url_for(@profile_owner.avatar) if @profile_owner.avatar.persisted? 

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
    @participations = Participant.where(:user_id => current_user.id)
    @message_rooms = []
    @receivers = []
    @avatars = []

    @participations.each do |p| 
      @room = Room.find(p.room_id)
      @message_rooms.append(@room)
      @receiver = get_receiver(@room)
      
      @receivers.append(@receiver)
      @receiver.avatar.persisted? ? @avatars.append(@receiver.avatar) : @avatars.append('default.png')
    end 

    @message_rooms = @message_rooms.uniq
    @receivers = @receivers.uniq
  end

  private
  def get_name(user1, user2)
    users = [user1, user2].sort
    return "private_#{users[0].id}_#{users[1].id}"
  end

  def get_receiver(room)
    talking_to_self = room.participants[0].user_id = room.participants[1].user_id
    return User.find(room.participants[0].user_id) if talking_to_self
    return User.find(room.participants.where.not(user_id: current_user.id)[0].user_id)
  end
   
end
