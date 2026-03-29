require "rails_helper"

RSpec.describe Message, type: :model do
  describe "validations" do
    it "is valid with content" do
      expect(build(:message)).to be_valid
    end

    it "is invalid without content and without image" do
      expect(build(:message, content: nil)).not_to be_valid
    end

    it "is valid without content when image is attached" do
      message = build(:message, content: nil)
      message.image.attach(
        io: File.open(Rails.root.join("spec/fixtures/files/test_image.png")),
        filename: "test_image.png",
        content_type: "image/png"
      )
      expect(message).to be_valid
    end
  end

  describe "associations" do
    it "belongs to user" do
      expect(build(:message).user).to be_a(User)
    end

    it "belongs to room" do
      expect(build(:message).room).to be_a(Room)
    end
  end
end
