class LikesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :require_correct_user_to_delete_like, only: [:destroy]

  def create
  	user1 = User.find(session[:user_id])
  	secret1 = Secret.find(params[:secret_id])
  	like = Like.new(user: user1, secret: secret1)
  	if like.save
  	  redirect_to "/secrets", notice: "Like successfully created"
	else 
      flash[:errors] = like.errors.full_messages
      redirect_to "/secrets"
    end
  end

  def destroy
  	# like = Like.where(user: current_user, secret: Secret.find(params[:secret_id])).first
  	like = Like.find(params[:id])

    if like.user == current_user
	  like.destroy 
      redirect_to "/secrets"
	else
	  redirect_to "/secrets"
	end 
  end
end
