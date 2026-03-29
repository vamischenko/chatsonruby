require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with name, email and password" do
      expect(build(:user)).to be_valid
    end

    it "is invalid without name" do
      expect(build(:user, name: nil)).not_to be_valid
    end

    it "is invalid without email" do
      expect(build(:user, email: nil)).not_to be_valid
    end

    it "is invalid with duplicate email" do
      create(:user, email: "test@example.com")
      expect(build(:user, email: "test@example.com")).not_to be_valid
    end
  end

  describe "associations" do
    it "has many rooms through room_users" do
      user = create(:user)
      room = create(:room)
      room.users << user
      expect(user.rooms).to include(room)
    end

    it "destroys messages on user destroy" do
      user = create(:user)
      room = create(:room)
      room.users << user
      create(:message, user: user, room: room)
      expect { user.destroy }.to change(Message, :count).by(-1)
    end
  end
end
