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
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  def name
    "#{first_name} #{last_name}"
  end

  def sent_requests_users
    requests = self.friend_requests.where(accepted: false, sender_id: self.id).pluck(:receiver_id)
    User.where(id: requests)
  end

  def received_requests_users
    requests = self.friend_requests.where(accepted: false, receiver_id: self.id).pluck(:sender_id)
    User.where(id: requests)
  end

  def friends
    friends_ids = self.friend_requests.where(accepted: true, sender_id: self.id).pluck(:receiver_id) +
    self.friend_requests.where(accepted: true, receiver_id: self.id).pluck(:sender_id)
    User.where(id: friends_ids)
  end

  def friends_posts
    Post.where(user_id: friends.ids)
  end

  def friend_request_from?(user)
    received_requests_users.include?(user)
  end

  def friend_request_to?(user)
    sent_requests_users.include?(user)
  end

  def friends_with?(user)
    friends.include?(user)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name
      user.last_name = auth.info.name
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
