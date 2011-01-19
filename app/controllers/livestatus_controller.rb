class LivestatusController < ApplicationController
	helper :all

	
  def tac
	  ls=Livestatus.new(get_user)
	  @hosts=ls.get_host_tac
	  @services=ls.get_service_tac
  end

  def view
	  ls=Livestatus.new(get_user)
	  logger.debug("muuh view"+get_user)
	  if params[:type] == "service"
		  filter = case params[:filter]
			   when "probs" then Livestatus::FILTER_SERVICE_PROBS
			   when "uprobs" then Livestatus::FILTER_SERVICE_UPROBS
			   when "all" then ""
			   else ""
			   end
		 @services=paginate_collection(ls.get_services(filter),:page => params[:page],:per_page=> 10)
	  elsif params[:type] == "host"
		  filter = case params[:filter]
			   when "probs" then Livestatus::FILTER_HOST_PROBS
			   when "uprobs" then Livestatus::FILTER_HOST_UPROBS
			   when "all" then ""
			   else ""
			   end
		  @hosts=paginate_collection(ls.get_hosts(filter),:page => params[:page],:per_page=> 10)
	  else
		 @services=paginate_collection(ls.get_services(),:page => params[:page],:per_page=> 10)

	  end
	 
  end
  private
  def get_user
	  if current_user.admin?
		  logger.debug "------ user #{current_user.name} email #{current_user.email} seems to bee admin..."
		  "Admin"
	  else
		  logger.debug "------ user #{current_user.name} email #{current_user.email} seems to be no admin..."
		  if current_user.name =~ /admin/i
			  flash[:error]="seems you have a illegal username..... Trying to fake an admin account?"
			  "damnichhabeversuchteinen admin zu faken?"
		  end
		  current_user.name
	  end
  end

  def paginate_collection(collection, opts = {})
	  opts[:per_page] ||= 20
	  opts[:page] ||= 1
	  opts[:page] = opts[:page].to_i
	  returning WillPaginate::Collection.new( opts[:page], opts[:per_page], collection.size ) do |pager|
		  start = (opts[:page]-1) * opts[:per_page]
		  finish = start + opts[:per_page]
		  pager.replace collection[ start...finish ]
	  end
  end









end
