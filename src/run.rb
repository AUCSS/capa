#
# Run.rb
#
# For running separate modules in ./run
#

def run(command,*args)
	path="./run/#{command}.rb";
	$console.log("Running #{path} using ruby 'load'...");
	load(path)
	$console.verbose("send(#{command},#{args})");
	send(command, args)
end
