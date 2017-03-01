#
# Capa math.rb
#

require("json");
require("./lib/algebra.rb");

algebra=Algebra.new();

args=JSON.parse(ENV["test"]);

args.each do |a|
	algebra.solve(a);
end
