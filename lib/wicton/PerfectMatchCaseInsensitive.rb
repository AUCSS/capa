#
# Perfect match
#

require("./lib/wicton/Algorithm.rb");

class PerfectMatchCaseInsensitive < Algorithm
	def solve(question)
		super(question.upcase);
	end
	def train(question,answer)
		super(question.upcase,answer);
	end
end

$algorithms.push(PerfectMatchCaseInsensitive.new);
