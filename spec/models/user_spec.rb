require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :name => "max exampleman",
      :email => "user@example.com",
      :password => "muhundrah",
      :password_confirmation => "muhundrah",
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name " do
	  no_name_user=User.new(@attr.merge(:name=>""))
	  no_name_user.should_not be_valid
  end
  it "should require a email " do
	  no_name_user=User.new(@attr.merge(:email=>""))
	  no_name_user.should_not be_valid
  end
  it "should not accept to long usernames" do
	  long_name= "a" * 50
	  lname_user=User.new(@attr.merge(:name => long_name))
	  lname_user.should_not be_valid
  end

  it "should accept valid emailaddresses" do
	  addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
	  addresses.each do |a|
		  valid_email_user=User.new(@attr.merge(:email=> a ))
		  valid_email_user.should be_valid
	  end
  end
  it "should reject  invalid emailaddresses" do
	  addresses = %w[user@foo,com THE.USER@foo. first.last.at.foo.jp]
	  addresses.each do |a|
		  invalid_email_user=User.new(@attr.merge(:email=> a ))
		  invalid_email_user.should_not be_valid
	  end
  end
  it "should reject duplicate emails" do 
	  ucased_mail=@attr[:email].upcase
	  User.create!(@attr)
	  dupl_mail_user=User.new(:name => "hans wurst",:email=> ucased_mail)
	  dupl_mail_user.should_not be_valid
  end

  describe "password validation" do
	  it "should require a password" do
		  User.new(@attr.merge(:password => "",:password_validation => ""))
			   should_not be_valid
	  end

	  it "should require valid password confirmation" do
		  User.new(@attr.merge(:password_confirmation => ""))
		  should_not be_valid
	  end

	  it "should reject short passwords" do
		  pw = "b" * 5
		  User.new(@attr.merge(:password => pw,:password_validation => pw))
		  should_not be_valid
	  end

	  it "should reject long passwords" do
		  pw = "a" * 40
		  User.new(@attr.merge(:password=>pw,:password_confirmation => pw))
		  should_not be_valid
	  end
  end
  describe "password encryption" do
	  before (:each) do
		  @user=User.create!(@attr)
	  end

	  it "should have an encrypted password attribute" do
		  @user.should respond_to(:encrypted_password)
	  end
	  it "should set the encrypted password" do
		  @user.encrypted_password.should_not be_blank
	  end
	  describe "has_password? method tests" do
		  it "should be true if passwords match" do
			  @user.has_password?(@attr[:password]).should be_true
		  end
		  it "should be false if passwords dont match" do
			  @user.has_password?("wurstbaum").should be_false
		  end
	  end
	  describe "autentication" do
		  it "should return nil on user/pw mismatch" do
			  wpw_user = User.authenticate(@attr[:email],"wurstpassword")
			  wpw_user.should be_nil
		  end

		  it "should return nil on nonexistant user" do
			  nx_user = User.authenticate("wurst@dosenwurst.com",@attr[:password])
			  nx_user.should be_nil
		  end

		  it "should return the User on correct credentials" do
			  good_user = User.authenticate(@attr[:email],@attr[:password])
			  good_user.should == @user
		  end
	  end

  end
  describe "remember me " do
	  before(:each) do
		  @user =User.create(@attr)
	  end

	  it "should have a remember token" do
		  @user.should respond_to(:remember_token)
	  end

	  it "should have a remember_me! method " do
		  @user.should respond_to(:remember_me!)
	  end

	  it "should set the remember token" do
		  @user.remember_me!
		  @user.remember_token.should_not be_nil
	  end
  end
  describe "micropost assos" do
	  before(:each) do
		  @user=User.create(@attr)
		  @mp1=Factory(:micropost,:user=>@user, :created_at => 1.day.ago)
		  @mp2=Factory(:micropost,:user=>@user, :created_at => 1.hour.ago)
	  end
	  it "shoudl have a micorpost asso" do
		  @user.should respond_to(:microposts)
	  end
	  it "should have the right order" do
		  @user.microposts.should == [@mp2,@mp1]
	  end
	  it "should destroy the associated microposts" do
		  @user.destroy
		  [@mp1,@mp2].each do |m|
			  Micropost.find_by_id(m.id).should be_nil
		  end
	  end
	  describe "status feed" do
		  it "should have a feed" do
			  @user.should respond_to(:feed)
		  end

		  it "should include the users posts" do
			  @user.feed.include?(@mp1).should be_true
			  @user.feed.include?(@mp2).should be_true
		  end
		  it "should not include other users posts" do
			  mp3=Factory(:microposts,:user=> Factory(:user,:email => Factory.next(:email)))
			  @user.feed.include?(mp3).should_not be_true
		  end
	  end
  end

end
