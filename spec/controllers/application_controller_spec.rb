require 'spec_helper'

describe ApplicationController do
  describe "#current_user" do
    let(:user) { create(:user) }

    before { allow(controller).to receive(:session).and_return( {email: user.email} ) }

    it "finds an existing user" do
      expect(controller.current_user.id).to eq(user.id)
    end
  end
end