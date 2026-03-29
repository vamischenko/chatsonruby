require "rails_helper"

RSpec.describe "Rooms", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before { sign_in user }

  describe "GET /rooms/new" do
    it "returns 200" do
      get new_room_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /rooms" do
    context "with valid params" do
      it "creates a room and redirects to root" do
        expect {
          post rooms_path, params: { room: { name: "Test Room", user_ids: [other_user.id, user.id] } }
        }.to change(Room, :count).by(1)
        expect(response).to redirect_to(root_path)
      end

      it "adds current user as member even if not in params" do
        post rooms_path, params: { room: { name: "Test Room", user_ids: [other_user.id, user.id] } }
        expect(Room.last.users).to include(user)
      end
    end

    context "with invalid params" do
      it "renders new on blank name" do
        post rooms_path, params: { room: { name: "", user_ids: [user.id] } }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE /rooms/:id" do
    context "when user is a member" do
      let!(:room) { create(:room).tap { |r| r.users << user } }

      it "destroys the room and redirects" do
        expect { delete room_path(room) }.to change(Room, :count).by(-1)
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is not a member" do
      let!(:room) { create(:room).tap { |r| r.users << other_user } }

      it "does not destroy the room" do
        expect { delete room_path(room) }.not_to change(Room, :count)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
