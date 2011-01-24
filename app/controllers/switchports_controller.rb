class SwitchportsController < ApplicationController
	def new
		@switchport=Switchport.new()
		@users=User.all
	end
	def index
		@switchports=Switchport.all
	end
	def create
		@switchport=Switchport.new(params[:switchport])
		if @switchport.save
			flash[:success] = "Port added"
			redirect_to switchports_path
		else
			flash[:error] = "port failure"
			render 'new'
		end
	end
	def edit
		@switchport=Switchport.find_by_id(params[:id])
	end
	def update
		@switchport=Switchport.find_by_id(params[:id])
		if @switchport.update_attributes(params[:switchport])
			flash[:success]= "Port Updated"
			redirect_to switchports_path
		else
			flash.now[:error]= "Didn work"
			render 'edit'
		end
	end

end
