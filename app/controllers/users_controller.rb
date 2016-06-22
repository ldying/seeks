class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/users/#{User.last.id}", notice: "User successfully created"

    else 
      # @user
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/new"
    # render "index"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user1 = User.find(params[:id])
    name = params[:user][:name]
    email = params[:user][:email]
    user1.name = name
    user1.email = email
    if user1.save
      redirect_to "/users/#{user1.id}"
    else
      flash[:errors] = user1.errors.full_messages
      redirect_to "/users/#{params[:id]}/edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    session[:user_id] = nil

    redirect_to "/sessions/new"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
