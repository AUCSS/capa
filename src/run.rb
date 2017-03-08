#
# Run.rb
#
# For running separate modules in ./run
#

def run(command,*args)
	path="./run/#{command}.rb";

	$console.log("Running #{path} using ruby 'load'...");
	load(path);

	$console.dump("send(#{command},#{args})");
	returns=send(command, *args);

	$console.debug("Command #{command} returned #{returns} (#{returns.class})");

	# parse the returns, put them as a string
	if not returns.nil?
		if returns.is_a? String
			puts(returns);
		end
		if returns.is_a? Array
			returns.each do |r|
				puts(r);
			end
		end
	end

end
