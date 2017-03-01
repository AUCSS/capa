#
# Capa math.rb
#

require("json");
require("./lib/algebra.rb");

def math(input)
	algebra=Algebra.new();

	args=input;

	args.each do |a|
		algebra.solve(a);
	end
end
