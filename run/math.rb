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
		result=algebra.solve(a);

		if (result.to_i==result)
			result=result.to_i
		end
		
		results.push(result);
	end

	return results;
end
