class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
 	if user && user.authenticate(params[:password])
 	  session[:user_id] = user.id
 	  redirect_to "/users/#{session[:user_id]}"
 	else
      flash[:errors] = ["Invalid Login"]
	  redirect_to '/sessions/new' 		
 	end
  end

  def destroy
  	session[:user_id] = nil
  	# session.destroy
	redirect_to '/sessions/new' 		
  end
end
