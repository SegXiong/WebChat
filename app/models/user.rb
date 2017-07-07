class User < ApplicationRecord
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :conversations, :foreign_key => :sender_id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def display_user_name
    self.user_name

  end

  def unread(user, friend)
    conversation = Conversation.between(user.id, friend.id).first
    if !conversation.nil?
      conversation.messages.where(:read => false, :user_id => friend.id).count
    else
      0
    end

  end

end
