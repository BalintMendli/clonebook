class FriendRequest < ApplicationRecord
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  validates :sender, uniqueness: { scope: :receiver}
  validate :no_request_other_way

  private

    def no_request_other_way
      if FriendRequest.where(sender: receiver, receiver: sender).exists?
        errors.add(:base, 'The relationship already exists!')
      end
    end
end
