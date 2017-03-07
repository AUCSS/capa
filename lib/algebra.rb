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

# FIXME: Someone tell me how to do this properly
class Ops
	def +(a,b)
		$console.debug("Summing #{a} and #{b}!");
		return a+b;
	end
	def -(a,b)
		$console.debug("Subtracting #{b} from #{a}!");
		return a-b;
	end
	def *(a,b)
		$console.debug("Multiplying #{a} and #{b}!");
		return a*b;
	end
	def /(a,b)
		$console.debug("Dividing #{a} by #{b}!");
		return a/b;
	end
end
$ops=Ops.new();
$operators={
	"priority":{
		"(":1,
		")":1,
		"+":2,
		"-":2,
		"*":3,
		"/":3
	},
	"associativity":{
		# 00 - not associative, 01 - right, 10 - left, 11 - both
		"+":2,
		"-":2,
		"*":2,
		"/":2
	},
	"arguments":{
		"+":2,
		"-":2,
		"*":2,
		"/":2
	}
};

class Algebra
	def calcpostfix(*post)
		$console.debug("Execute postfix: #{post}");

		stack=[];
		
		post.each do |t|
			tsym = t.to_sym;
			$console.dump("Token #{t}");
			if ($ops.respond_to? t)
				# do the operation with our stack
				$console.dump("Our stack is #{stack}");
				
				ar=$operators[:arguments][tsym];
				$console.log("Operation arguments: #{ar}");
				
				# TODO: Handler for when there are not enough arguments!
				popped=stack.pop(ar);

				# Send the popped array to the operator
				$console.log("sym is #{tsym}");
				result=$ops.send(t,*popped);

				# Push the result back in
				$console.info("Math res: #{result}");
				stack.push(result);
			else
				if (numeric? t)
					# push the value onto the stack.
					stack.push(t.to_f);
				else
					# cannot determine what the value is
					$console.error("Cannot parse operator: #{t}!");
				end
			end
		end
		$console.dump("Our stack, after evaluation, is #{stack}");
		if (stack.size==1)
			return stack[0];
		else
			$console.warn("Stack contains more than 1 value!");
			return stack[0];
		end
	end
	def boundaries(str)
		# Try to figure out where the boundaries are.
		# e.g. "sin(2*5)" is not s*i*n(2*5), unfortunately, but abc might be a*b*c.
		# and 25 is not 2*5
		
		# Consider this example. 2+2-(4*5)+20
		# This needs to evaluate to [2, +, 2, -, (, 4, *, 5, ), +, 20]
		return str.scan(/\d+(?:\.\d+)?|[\+\-\/\*\(\)]/);
	end
	def solve(string)
		
		expr=boundaries(string);

		$console.debug("Expression: #{expr}");

		post=infix2postfix(expr);

		return calcpostfix(*post);
	end
	def infix2postfix(input)
		$console.log("Converting infix to postfix...");
		
		output=[];
		opstack=[];

		input.each do |a|
			if numeric? a
				output.push(a);
			else
				if a=="("
					opstack.push(a);
				else
					if a==")"
						top = opstack.pop();
						while (top!="(")
							output.push(top);
							top = opstack.pop();
						end
					else
						# operator
						# check priority
						selfpriority = $operators[:priority][a.to_sym];
						if !opstack.empty?
							op=$operators[:priority][opstack[-1].to_sym]; 
							$console.dump("IIit is #{opstack[-1]}");
							$console.dump("Test if #{op} >= #{selfpriority}");
							while (!opstack.empty? && $operators[:priority][opstack[-1].to_sym] >= selfpriority)
								output.push(opstack.pop());
							end
						end

						$console.dump("Pushing #{a}");
						opstack.push(a);
					end
				end
			end
		end

		while !opstack.empty?
			output.push(opstack.pop());
		end

		$console.log("Conversion complete! #{output}");
		return output
	end
end
