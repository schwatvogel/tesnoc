require 'spec_helper'

describe SessionsController do
	integrate_views



  describe "POST 'create'" do
	  before(:each) do
		  @attr= {:email => "wurst@brot.de",
			  :password => "wurstbrot"}
		  User.should_receive(:authenticate).
			  with(@attr[:email],@attr[:password]).
			       and_return(nil)
	  end

	  it "should re-render the new page " do
		  post :create, :session => @attr
		  response.should render_template('new')
	  end

	  it "should have the right title" do
		  post :create, :session => @attr
		  response.should have_tag("title",/sign in/i)
	  end

	  describe "with valid login data" do

		  before(:each) do
			  @user=Factory(:user)
			  @attr= { :email => @user.email, :password=> @user.password }
			  User.should_receive(:authenticate).
				  with(@user.email,@user.password).
				  and_return(@user)
		  end

		  it "should sign the user in"  
#			  post :create, :session => @atrr
#			  puts("current user "+controller.current_user)
#			  controller.current_user.should == @user
#			  controller.should be_signed_in
#		  end
#
		  it "should redirect to the profile page" 
#			  post :create, :session => @attr
#			  response.should redirect_to(user_path(@user))
#		  end
	  end
  end
  describe "DELETE 'destroy'" do
	  it "shoudl sign a user out " 
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  
    it "should have the right title" do
	    get 'new'
	    response.should have_tag("title", /sign in/i)
    end
  
  end
end
