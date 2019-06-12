class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.references :sender
      t.references :receiver
      t.boolean :accepted, :default => false

      t.timestamps
    end

    add_foreign_key :friend_requests, :users, column: :sender_id, primary_key: :id
    add_foreign_key :friend_requests, :users, column: :receiver_id, primary_key: :id
  end
end
