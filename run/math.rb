#
# Capa math.rb
#

require("json");
require("./lib/algebra.rb");

def math(*args)
	algebra=Algebra.new();

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
