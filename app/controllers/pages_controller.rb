class PagesController < ApplicationController
  def home
	@title="Home"
	if signed_in?
		@micropost=Micropost.new 
		@feed_items=current_user.feed.paginate(:page => params[:page],:per_page=> 10)
	else
		@feed_items=[]
	end
  end
  def hosts
	  @title="HOST Monitoring"
	  if signed_in?
		  if current_user.admin?
			   @hosts=@template.get_hosts("Admin")
		  else
			   @hosts=@template.get_hosts(current_user.name)
		  end
	  end
  end

  def services
	  @title="Service Monitoring"
	  @host=params[:host_name]
	  if signed_in?
		  if current_user.admin?
				  @services=@template.get_services_by_host("Admin",@host)
		  else
			  if @host.blank?
				  @services=@template.get_services_by_host(current_user.name)
			  else
				  @services=@template.get_services_by_host(current_user.name,@host)
			  end
		  end
	  end
  end
  def tac
	  @title="Tactical Overview"
  end




  def about
	@title="About"
  end
  
  def contact
	@title="Contact"
  end
  
  def help
	@title="Help"
  end
  def impressum
	@title="Impressum"
  end

end
