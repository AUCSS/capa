#
# prompt.rb
# CAPA prompt
#

def prompt(*cmds)
	$console.log("Initializing CAPA prompt...");

	# TODO: Some way to make the prompt non-blocking?
	# The while loop currently stops everything else from executing.

	while true
		begin
			eval(STDIN.gets());
		rescue => e
			$console.error("Command error: #{e.to_s}");
		end
	end
end
