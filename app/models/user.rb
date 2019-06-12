class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :sent_friend_requests, :class_name => 'FriendRequest', :foreign_key => 'sender_id'
  has_many :received_friend_requests, :class_name => 'FriendRequest', :foreign_key => 'receiver_id'
  has_many :sent_requests_friends, through: :sent_friend_requests, :source => :receiver
  has_many :received_requests_friends, through: :received_friend_requests, :source => :sender
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def confirmed_friends
    self.sent_requests_friends.where("accepted = ?", true) + self.received_requests_friends.where("accepted = ?", true)
  end

  def unconfirmed_sent_requests_friends
    self.sent_requests_friends.where("accepted = ?", false)
  end

  def unconfirmed_received_requests_friends
    self.received_requests_friends.where("accepted = ?", false)
  end
end
