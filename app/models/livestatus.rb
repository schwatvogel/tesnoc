class Livestatus 
require 'socket'
	attr_reader :user
	FILTER_SERVICE_UPROBS="Filter: state != 0\nFilter: acknowledged = 0"
	FILTER_SERVICE_PROBS="Filter: state != 0"
	FILTER_HOST_UPROBS="Filter: state != 0\nFilter: acknowledged = 0"
	FILTER_HOST_PROBS="Filter: state != 0"
	def initialize(user)
		@user=user

	end
	def inspect
		"A MKlivestatus interface"
	end

	def get_hosts(filter="")
		if filter.blank?
			query="GET hosts"
		else
			query="GET hosts\n#{filter}"
		end
		list=query(query)
		list
	end

	def get_services(filter="")
		if filter.blank?
			query="GET services"
		else
			query="GET services\n#{filter}"
		end
		list=query(query)
		list
	end

	def get_service_tac
		query="GET services \nStats: state = 0\nStats: state = 1\nStats: state = 2\nStats: state = 3\nStats: state = 1\nStats: acknowledged = 0\nStatsAnd: 2\nStats: state = 2\nStats: acknowledged = 0\nStatsAnd: 2\nStats: state = 3\nStats: acknowledged = 0\nStatsAnd: 2\nStats: state = 1\nStats: scheduled_downtime_depth = 1\nStats: host_scheduled_downtime_depth = 1\nStatsOr: 2\nStatsAnd: 2\nStats: state = 2\nStats: scheduled_downtime_depth = 1\nStats: host_scheduled_downtime_depth = 1\nStatsOr: 2\nStatsAnd: 2\nStats: state = 3 \nStats: scheduled_downtime_depth = 1\nStats: host_scheduled_downtime_depth = 1\nStatsOr: 2\nStatsAnd: 2\nStats: state = 1\nStats: host_state != 0\nStatsAnd: 2\nStats: state = 2\nStats: host_state != 0\nStatsAnd: 2\nStats: state = 3\nStats: host_state != 0\nStatsAnd: 2"
#		query="GET services\nStats: state = 0\nStats: state = 1\nStats: state = 2\nStats: state = 3"
		list=query(query)
		list
	end
	def get_host_tac
		query="GET hosts\nStats: state = 0\nStats: state = 1\nStats: state = 2\nStats: state = 3\nStats: state = 1\nStats: acknowledged = 0\nStatsAnd: 2\nStats: state = 2\nStats: acknowledged = 0\nStatsAnd: 2\nStats: state = 3\nStats: acknowledged = 0\nStatsAnd: 2\nStats: state = 1\nStats: scheduled_downtime_depth = 1\nStatsAnd: 2\nStats: state = 2\nStats: scheduled_downtime_depth = 1\nStatsAnd: 2\nStats: state = 3 \nStats: scheduled_downtime_depth = 1"
#		query="GET hosts\nStats: state = 0\nStats: state = 1\nStats: state = 2\nStats: state = 3"
		list=query(query)
		list
	end


	def get_up_hosts_test
		query="GET hosts\nFilter: state = 0"
		list=query(query)
		list.each do |l|
			puts "name: #{l["name"]},address #{l["address"]}"
		end
	end



	private 
	def query(string)
		socket=build_socket
		query= build_auth_query(string)
		res=parse_result(process_query(socket,query))
		res
	end
	
	def build_auth_query(string)
		string+="\nSeparators: 10 33 44 124"
		unless  @user =~ /Admin/i
			query_string=string + "\nAuthUser: #{@user}\n\n"
		else
			query_string=string+"\n\n"
		end

		query_string
	end



	def parse_result(result)
		list=[]
		element={}	
		if result.split("\n").length > 1
			ar=result.split("\n")
			header=ar.shift
			header=header.split("!")
			ar.each do |line|
				i=0
				element={}
				line.split("!").each do |e|
					element[header[i]] = e
					i += 1
				end
				list.push element
			end
			list
		else
			result=result.chomp
			ar=result.split("!")
			ar
		end
	end


	
	def process_query(socket,query)
		puts query
		socket.print(query)
		response=socket.read
		response
	end
	def build_socket
		sock=UNIXSocket.new('/usr/local/nagios/var/rw/live')
		sock
	end


	
end
