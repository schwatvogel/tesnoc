class Host
	require 'socket'
	attr_reader :name, :alias, :address,:state,:last_check, :next_check, :services
	def initialize(name, nalias, address, state, last_check, next_check)
		@name=name
		@alias=nalias
		@address=address
		@state=state
		@last_check=last_check
		@next_check=next_check


	end
	
	def number_of_services
		@services.length
	end

	def service_names
		@services.each do |s|
			print s.description+"\n"
		end
	end

	private

	def populate_services
		tmpservices=[]
		sock=UNIXSocket.new('/usr/local/nagios/var/rw/live')
		sock.print("GET services\nFilter: host_name = #{@name}\nColumns: description state host_name next_check last_check acknowledged pnpgraph_present\n\n")
		response=sock.read
		unless response.nil?
			response.each_line do |l|
				s=l.split(";")
				service=Service.new(s[0],s[1],s[2],s[3],s[4],s[5],s[6])
				tmpservices.push service
			end
		end
		tmpservices
	end
end
