class AddIndexToMessagesRoomIdCreatedAt < ActiveRecord::Migration[6.1]
  def change
    add_index :messages, [:room_id, :created_at]
  end
end
