module MicropostsHelper
	def wrap(content)
		content.split.map{ |s| wrap_long_strings(s)}.join(' ')
	end
	private

	def wrap_long_strings(string, max_width=30)
		zero_width_space = "&#8203;"
		regex =/.{1,#{max_width}}/
		(string.length < max_width) ? string : string.scan(regex).join(zero_width_space)
	end
end






