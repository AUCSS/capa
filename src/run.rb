#
# Run.rb
#
# For running separate modules in ./run
#

def run(command,*args)
	# Split command into filename and methodname
	# So, for example, "time.get" would call file "time" and method "get"
	# If we call "time" it gets automatically expanded to "time.time" (method "time" from file "time")
	# We can also do some neat stuff with this.
	# If we call ".time", we can call the method "time" without loading the file.
	# Or, if we call "time." we can load the file "time" but not call any method.

	# Split "command" into 2 parts
	
	if (!command.include? ".")
		# Command does not have a dot, so we expand it to "cmd.cmd"
		filepart=command;
		methodpart=command;
	else
		filepart=command.split(".")[0];	
		methodpart=command.split(".")[1];
	end

	$console.debug("RUN: Filepart: #{filepart}, Methodpart: #{methodpart}");

	if (!filepart.to_s.empty?)
		# Call file (PART 1)
		
		file="./run/#{filepart}.rb";

		$console.log("Running #{file} using ruby 'load'...");
		if File.file?(file) then	
			load(file);
		else
			$console.error("File for '#{filepart}' does not exist!");
			return;
		end
	end

	# Run method and parse results (PART 2)
	
	if (!methodpart.to_s.empty?)
		begin
			$console.dump("send(#{methodpart},#{args})");
			returns=send(methodpart, *args);
			$console.debug("Command #{command} returned #{returns} (#{returns.class})");
		rescue => err
			$console.error("Method '#{methodpart}' failed: #{err}");
		end
	end

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
