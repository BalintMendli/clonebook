class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friend_requests, ->(user) { unscope(where: :user_id)
                                        .where("sender_id = ? OR receiver_id = ?", user.id, user.id) }, 
                                        :class_name => 'FriendRequest'
  
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def sent_requests_users
    self.friend_requests.where(accepted: false, sender_id: self.id)
  end

  def received_requests_users
    self.friend_requests.where(accepted: false, receiver_id: self.id)
  end

  def friends
    friends_ids = self.friend_requests.where(accepted: true, sender_id: self.id).pluck(:receiver_id) +
    self.friend_requests.where(accepted: true, receiver_id: self.id).pluck(:sender_id)
    User.where(id: friends_ids)
  end

  def friends_posts
    Post.where(user_id: friends.ids)
  end
end
