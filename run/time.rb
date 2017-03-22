#!/usr/bin/env ruby
# TODO: Fix the arguments to get only the first one
def time(*input)
	if !input.empty? then
		o= input[0].split(":").to_a
	else
		o = ["00", "00"]
	end
	return (Time.now+o[0].to_i*3600+(o[0][0]=="-"?-o[1].to_i*60: o[1].to_i*60)).strftime "%H:%M"
end
