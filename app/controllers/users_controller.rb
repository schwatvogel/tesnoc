class UsersController < ApplicationController
	filter_parameter_logging :password
	before_filter :authenticate, :only => [:edit,:update,:index]
	before_filter :correct_user, :only => [:edit,:update]
	before_filter :admin_user, :only => :destroy
	before_filter :not_signed_in, :only => [:new,:create]
  def new
	  @title="Sign Up"
	  @user=User.new
  end
  def index
	  @title= "All Users"
	  @users=User.paginate(:per_page=> 30,:order =>"name",:page=>params[:page])
  end
  def show
	  @user=User.find(params[:id])
	  @microposts=@user.microposts.paginate(:page=> params[:page],:per_page => 10)
	  @title=@user.name
  end
  def create
	  @user = User.new(params[:user])
	  if @user.save
		  sign_in(@user)
		  flash[:success]= "Welcome to the sample app"
		  redirect_to @user
	  else
		  @title = "Sign Up"
		  render 'new'
	  end
  end
  def edit
	  @title = "Edit User - #{@user.name}"
  end
  def update
	  if @user.update_attributes(params[:user])
		  flash[:success] = "Profile updated"
		  redirect_to @user
	  else
		  flash.now[:error] = "You Suck"
		  @title="Edit User - #{@user.name}"
		  render 'edit'
	  end
  end
  def destroy
	  User.find(params[:id]).destroy
	  flash[:success]="User deleted!"
	  redirect_to users_path
  end


  private
  def not_signed_in
#	  flash[:error]="dont try this"
	  redirect_back_or(current_user) if signed_in?
  end

  def correct_user
	  @user=User.find(params[:id])
	  unless current_user?(@user)
		  flash[:notice]="Access Denied,edit your own stuff"
		  redirect_to root_path
	  end
  end
  def admin_user
	  redirect_to(root_path) unless current_user.admin?
  end


end
