require 'rails_helper'
RSpec.describe LikesController, type: :controller do
  before do
    @user = create_user
    @secret = Secret.create(user: @user, content: "NEW SECRET")
  end
  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot like a secret" do
      post :create, secret_id: @secret.id       
      expect(response).to redirect_to('/sessions/new')

    end

    it "cannot unlike a secret" do
      like1 = Like.create(user: @user, secret_id: @secret.id)
      delete :destroy, id: like1 
      expect(response).to redirect_to('/sessions/new')
    end
  end
  describe "when logged in as wrong user" do
    before do
      @wrong_user = create_user 'julius', 'julius@lakers.com'
      session[:user_id] = @wrong_user.id
      @secret = @user.secrets.create(content: 'Ooops')
    end
    it "cannot create a like with user1 when logged in as user2" do
      post :create, secret_id: @secret.id
      expect(Like.last.user.id).to eq(@wrong_user.id)
    end

    it "cannot delete user1's like when logged in as user2" do
      like1 = Like.create(user: @user, secret_id: @secret.id)
      delete :destroy, id: like1
      expect(response).to redirect_to('/sessions/new')
    end
  end

end