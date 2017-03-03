#
# Capa math.rb
#

require("json");
require("./lib/algebra.rb");

def math(input)
	algebra=Algebra.new();

	args=input;

	results=[];

	args.each do |a|
		results.push(algebra.solve(a));
	end

	return results;
end
