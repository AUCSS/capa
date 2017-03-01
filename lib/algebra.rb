# 
# Algebra.rb
#
# A way for capa to understand algebraic expressions
# 
# For example, simple ones: 
# 1+1 -> 2
# 2**3 (or 2^3) -> 8
# 2*(2-3)
# 
# Some harder ones
# 2x=5
# 9x^2-2x=0
#

def numeric?(string)
	# Question. How do we actually define if a string is numeric?
	# 2 is numeric. Okay.
	# [ is not numeric. Okay.
	# 4.2 is numeric. ...right?
	# 4,2 is also numeric. Depends on the context...?
	# 	i.e. in sin(4,2) the comma is NOT numeric.
	# Is D numeric? What if it's hexadecimal?
	# 4.2e10 can be numeric.
	# 4.2e-10 as well.
	# is "pi" numeric? (...yes?)
	# How do we know?
	ret = (string =~ /\A-?\d+(\.\d+)?\Z/) != nil;
	$console.verbose("String #{string} is numeric? #{ret}");
	return ret;
end

class Algebra
	def solve(expr)
		# TODO try to figure out where the boundaries are.
		# e.g. "sin(2*5)" is not s*i*n(2*5), unfortunately, but abc might be a*b*c.
		# and 25 is not 2*5
		
		expr=expr.gsub(/\s+/,""); # remove all whitespace
		expr=expr.split(/\b/);    # split into an array by word boundaries

		$console.debug("Expression: #{expr}");

		infix2postfix(expr);
	end
	def infix2postfix(input)
		$console.log("Converting infix to postfix...");

		operators=["+","-"];
		
		output=[];
		operatorstack=[];

		input.each do |a|
			$console.debug(a);
			# if a is a number
			if numeric? a
				output.push(a);
			else
				# if a is an operator
				if operators.include? a
					$console.log("Pushing #{a}!");
					output.push(*operatorstack);
					operatorstack=[];
					operatorstack.push(a);
				else
					$console.log("else");
				end
			end
		end

		operatorstack.each do |o|
			output.push(o);
		end

		$console.log("Conversion complete! #{output}");
		return output
	end
end
