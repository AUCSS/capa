#
# Functionality for -h (--help)
#

def help(*)
	$console.log("Showing help text");

	# Capa name and version
	puts("#{$name} version #{$version}");

	# Git commit
	begin
	commit=File.read("./.git/refs/heads/master");
	puts("On git commit: #{commit}");
	rescue => e
		$console.error("Can't read git commit: #{e}");
	end

	# Usage
	puts("\nUsage: capa [arguments]");
	puts("   or: capa [command] [args]");

	# List of arguments
	puts("\n<List of supported arguments>");

	# Examples
	puts("\n<examples>")
end
