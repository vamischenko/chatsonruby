require "rails_helper"

RSpec.describe "Messages", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:room) { create(:room).tap { |r| r.users << user } }
  let!(:other_room) { create(:room).tap { |r| r.users << other_user } }

  before { sign_in user }

  describe "GET /rooms/:room_id/messages" do
    it "returns 200 for member" do
      get room_messages_path(room)
      expect(response).to have_http_status(:ok)
    end

    it "redirects non-member to root" do
      get room_messages_path(other_room)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST /rooms/:room_id/messages" do
    context "with valid params" do
      it "creates a message and redirects" do
        expect {
          post room_messages_path(room), params: { message: { content: "Hello!" } }
        }.to change(Message, :count).by(1)
        expect(response).to redirect_to(room_messages_path(room))
      end
    end

    context "with invalid params" do
      it "does not create a message and renders index" do
        expect {
          post room_messages_path(room), params: { message: { content: "" } }
        }.not_to change(Message, :count)
        expect(response).to have_http_status(:ok)
      end
    end

    context "in a room user doesn't belong to" do
      it "redirects to root without creating message" do
        expect {
          post room_messages_path(other_room), params: { message: { content: "Hack" } }
        }.not_to change(Message, :count)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
