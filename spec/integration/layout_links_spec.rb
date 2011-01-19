require 'spec_helper'

describe "LayoutLinks" do
	it "Should have a Home Page at '/'" do
		get '/'
		response.should render_template("pages/home")
	end

	it "Should have a About Page at '/about'" do
		get '/about'
		response.should render_template("pages/about")
	end

	it "Should have a Contact Page at '/contact'" do
		get '/contact'
		response.should render_template("pages/contact")
	end
	it "Should have a Help Page at '/help'" do
		get '/help'
		response.should render_template("pages/help")
	end
	it "Should have a Impressum Page at '/Impressum'" do
		get '/impressum'
		response.should render_template("pages/impressum")
	end

	it "Should have a Signup Page at '/signup'" do
		get '/signup'
		response.should render_template("users/new")
	end

	describe "when not signed in" do
		it "should have a sign in link" do
			visit root_path
			response.should have_tag("a[href=?]",signin_path,"Sign in")
		end

		it "should have a sign up link" do
			visit root_path
			response.should have_tag("a[href=?]",signup_path,"Sign up")
		end
	end

	describe "when signed in" do
		before (:each) do
			@user = Factory(:user)
			visit signin_path
			fill_in :email,		:with=>"smueller@internet4you.com"
			fill_in :password,	:with=>"smueller"
			click_button
		end
		it "should have a sign out link" do
			visit root_path
			response.should have_tag("a[href=?]",signout_path,"Sign out")
		end

		it "should have a profile link" do
			visit root_path
			response.should have_tag("a[href=?]",user_path(2),"Profile")
		end
		it "should not have a signin link" do
			visit root_path
			response.should_not have_tag("a[href=?]",signin_path,"Sign in")
		end
		it "should not have a sign up link" do
			visit root_path
			response.should_not have_tag("a[href=?]",signup_path,"Sign up")
		end
	end
end
