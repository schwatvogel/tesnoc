class SwitchesController < ApplicationController
  def index
	  @switches=Switch.all
  end

  def new
	  @switch=Switch.new()
  end
  def create
	  @switch=Switch.new(params[:switch])
	  if @switch.save
		  flash[:success]="switch created"
	  else
		  flash[:error]="something went wrong"
	  end
	  redirect_to @switch 
  end

  def show
  end

  def edit
	  @switch=Switch.find_by_id(params[:id])
  end
  def update
	  @switch=Switch.find_by_id(params[:id])
	  if @switch.update_attributes(params[:switch])
		  flash[:success]="Switch updated"
		  redirect_back_or switches_path
	  else
		  flash[:error]="Update failure"
		  render 'edit'
	  end
  end


  def delete
  end

end
