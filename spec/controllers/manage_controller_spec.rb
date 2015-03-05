require 'spec_helper'

describe ManageController do
  let(:user) { create(:user) }
  before { allow(controller).to receive(:session).and_return( {email: user.email} ) }

  describe "#create" do
    it "creates a new category for the current user" do
      expect { post :create, {name: 'Fun Stuff', budget: 1} }.to change {user.categories.count}.by(1)
    end

  end

  describe "#update" do
    let(:category) { create(:category, {user: user}) }

    it "updates a post with attributes" do
      put :update, { id: category.id, category: {name: 'Fun Category'} }
      expect(category.reload.name).to eq('Fun Category')
    end
  end

  describe "#destroy" do
    it "deletes a post" do
      category = user.categories.create
      expect { delete :delete, {id: category.id} }.to change {Category.count}.by(-1)
    end
  end

end