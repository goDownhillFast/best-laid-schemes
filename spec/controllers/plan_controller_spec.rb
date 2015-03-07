require 'spec_helper'

describe PlanController do
  let(:user) {create(:user)}
  let(:category) {create(:category)}
  describe "#create" do
    context "with a logged in user" do
      before { allow(controller).to receive(:current_user).and_return(user) }
      it "creates a new activity for a user and category" do
        expect { post :create }.to change {user.activities.count}.by(1)
        expect { post :create, {activity: {category_id: category.id}} }.to change {category.activities.count}.by(1)
      end
    end
    context "without a logged in user" do
      before { allow(controller).to receive(:current_user).and_return(nil) }
      it "doesn't create a new activity" do
        expect { post :create }.to_not change { Activity.count }
      end
      it "returns the correct error code" do
        post :create
        expect(response.code).to eq("403")
      end
    end
  end
end