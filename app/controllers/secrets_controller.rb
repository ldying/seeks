class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]

  def index
  	@secrets = Secret.all
  end

  # def new
  # end

  def create
  	user1 = User.find(session[:user_id])
  	secret1 = Secret.new(content: params[:secret][:content], user: user1 )
	if secret1.save
      redirect_to "/users/#{session[:user_id]}", notice: "Secret successfully created"

    else 
      # @user
      flash[:errors] = secret1.errors.full_messages
      redirect_to "/users/#{session[:user_id]}"
    # render "index"
    end
  end

  def destroy
    secret = Secret.find(params[:id])

    secret.destroy if secret.user == current_user

    redirect_to "/users/#{session[:user_id]}"
  end
end
