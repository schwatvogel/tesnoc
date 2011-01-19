class SessionsController < ApplicationController
	helper :all
#	include SessionsHelper
  def new
	  @title= "Sign In"
  end
  
  def create
	  user = User.authenticate(params[:session][:email],
				   params[:session][:password])
	  logger.info("user nil? " + user.nil?.to_s)
	  if user.nil?
		  flash.now[:error] = "Invalid login"
		  @title= "Sign In"
		  render 'new'
	  else
		  flash[:success] = "Successfully logged in"
		  sign_in user
		  redirect_back_or user
	  end
  end

  def destroy
	  sign_out
	  redirect_to root_path
  end

end
