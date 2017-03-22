#
# Perfect match
#

require("./lib/wicton/Algorithm.rb");

class PerfectMatch < Algorithm
	@@confidence=0.9;
	def solve(question)
		return super(question);
	end
	def train(question,answer)
		return super(question,answer);
	end
end

$algorithms.push(PerfectMatch.new);
