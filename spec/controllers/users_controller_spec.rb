require 'spec_helper'

describe UsersController do
	integrate_views

  #Delete these examples and add some real ones
  it "should use UsersController" do
    controller.should be_an_instance_of(UsersController)
  end
  describe "authentication of edit/update" do
	  before(:each) do
		  @user=Factory(:user)
	  end

	  describe "for non-signed in users" do
		  it "should deny access to 'edit'" do
			  get :edit, :id => @user
			  response.should redirect_to(signin_path)
		  end
		  it "should deny access to 'update'" do
			  get :update, :id => @user
			  response.should redirect_to(signin_path)
		  end
	  end
  end

  describe " GET 'show'" do
	  before(:each) do
		  @user=Factory(:user)
		  User.stub!(:find, @user.id).and_return(@user)
	  end

	  it "should be succesful" do
		  get :show,:id => @user
		  response.should be_success
	  end

	  it "should have the right title" do
		  get :show, :id=> @user
		  response.should have_tag("title" , /#{@user.name}/)
	  end
	  it "should show the users name" do
		  get :show, :id=> @user
		  response.should have_tag("h2" , /#{@user.name}/)
	  end
	  it "should show the users image" do
		  get :show, :id=> @user
		  response.should have_tag("h2>img" , :class => "gravatar")
	  end



  end
  describe "POST 'create'" do
	  describe "failure" do

		  before(:each) do
			  @attr = { 
				  :name => "",
				  :email => "",
				  :password => "",
				  :password_confirmation =>""
			  }
			  @user=Factory.build(:user,@attr)
			  User.stub!(:new).and_return(@user)
			  @user.should_receive(:save).and_return(false)
		  end

		  it "should have the right title" do
			  post :create, :user => @attr
			  response.should have_tag("title",/sign up/i)
		  end

		  it "should render the 'new' page" do
			  post :create, :user => @attr
			  response.should render_template('new')
		  end
	  end
	  describe "success" do
		  before(:each) do
			  @attr= {
				  :name => "muh die kuh",
				  :email => "kuh@muh.de",
				  :password => "sehrgeheim",
				  :password_confirmation => "sehrgeheim"
			  }
			  @user=Factory(:user)
			  User.stub!(:new).and_return(@user)
			  @user.should_receive(:save).and_return(true)
		  end

		  it "should redirect to the users profile page" do
			  post :create, :user => @attr
			  response.should redirect_to(user_path(@user))
		  end
		  it "should have a welcome flash" do
			  post :create,:user => @attr
			  flash[:success].should =~/Welcome to The Sample app/i
		  end
	  end

  end


	 

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    it "SHould have the right title" do
	    get 'new'
	    response.should have_tag("title",/Sign Up/)
    end
  end
end
