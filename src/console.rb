#
# A simple console for our program with different logging levels
# and the possibility of being more/less verbose.
#
# Usage:
#
# 	You need to first create a new instance of the Console class
#
#	console = Console.new;
#
#	You can now use all of the methods you want
#	console.log("hello");
#	console.tell("hello");
#	console.shout("hello");
#	console.adviosajvdasiodvjasiodjvsa("hello");
#
#	All of these are valid even if they're not defined.
#	You can then set the types here individually.
#	For example, if you call console.log, you're logging with type "log".
#	If you have a format {"log":"LOG: %s"}, your output will be:
#	"LOG: %s" % "hello"
#	> "LOG: hello"
#
#

$colors={
        default:"\x1b[0m",
        lightgreen:"\x1b[92m",
        lightyellow:"\x1b[93m",
        red:"\x1b[31m",
        green:"\x1b[32m",
        yellow:"\x1b[33m",
        blue:"\x1b[36m",
        magenta:"\x1b[35m",
        blink:"\x1b[5m",
        cyan:"\x1b[46m",
        gray:"\x1b[2m",
        darkgray:"\x1b[90m",
        bgdarkgray:"\x1b[100m"
};

class Console < BasicObject
	# How different types are formatted. String substitution is used.
	@@formats={
		"log":"Log: %s",
		"debug":$colors[:blue]+"Debug: %s"+$colors[:default],
		"error":$colors[:red]+"ERROR! %s"+$colors[:default],
		"warn":$colors[:yellow]+"Warn! %s"+$colors[:default],
		"info":$colors[:green]+"Info: %s"+$colors[:default],
		"dump":$colors[:darkgray]+"  %s"+$colors[:default]
	};

	# How different types are leveled, more important types have larger levels
	@@levels={
		"error":100,
		"warn":10,
		"info":-10,
		"log":-20,
		"debug":-50,
		"verbose":-75,
		"dump":-100
	};

	def level
		@level
	end
	def level=(level)
		@level=level
	end

	def initialize(level=1)
		@formats=@@formats;
		@levels=@@levels;

		# Which level we are on (log levels below this are not displayed)
		@level=level;
	end

	# Catch-all for all methods that don't exist
	# These get printed out nevertheless, accessed method name is the type
	def method_missing(type, *args, &block)
		# If log level is not sufficient, we shall not log
		if @levels[type].to_i<@level then return; end

		# If formatting for this type, format
		if @formats.key? type.to_sym
			args[0]=@formats[type] % args[0];
		end

		# Output our string (currently via puts)
		::Kernel.puts(*args);
	end
end
