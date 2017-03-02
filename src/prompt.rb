#
# prompt.rb
# CAPA prompt
#

def prompt(*cmds)
	$console.log("Initializing CAPA prompt...");

	# TODO: Some way to make the prompt non-blocking?
	# The while loop currently stops everything else from executing.

	while
		cmdl=STDIN.gets().split();
		cmd=cmdl[0];
		args=cmdl[1..-1];
		begin
			send(cmd,*args);
		rescue => e
			$console.error("Command error: #{e.to_s}");
		end
	end
end
