class Service 
attr_reader :description, :state, :host, :next_check, :last_check, :acknowledged, :pnpgraph_present
	def initialize(description=nil,state=nil,host=nil,next_check=nil,last_check=nil,acknowledged=nil,pnpgraph_present=nil)
		@description=description
		@state=state
		@host=host
		@next_check=next_check
		@last_check=last_check
		@pnpgraph_present=pnpgraph_present
		@acknowledged=acknowledged

	end
	def inspect
		"A Nagios Service Representation"
	end

	
end
