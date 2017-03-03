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

class Operators
	def +(*args)
		$console.debug("Summing #{args}!");
		return args.inject(0, :+);
	end
	def -(first,*args)
		$console.debug("Subtracting #{args} from #{first}!");
		return first-self.+(*args);
	end
end
$operators=Operators.new();

class Algebra
	def calcpostfix(*post)
		$console.debug("Execute postfix: #{post}");

		stack=[];
		
		post.each do |t|
			$console.dump("Token #{t}");
			if ($operators.respond_to? t)
				# do the operation with our stack
				$console.dump("Our stack is #{stack}");

				# FIXME: Currently everything has 2 arguments, however, with some functions (max(1,2,3,4)) it might be more.
				popped=stack.pop(2);

				# Send the popped array to the operator
				$console.log("sym is #{t.to_sym}");
				result=$operators.send(t,*popped);

				# Push the result back in
				$console.info("Math res: #{result}");
				stack.push(result);
			else
				if (numeric? t)
					# push the value onto the stack.
					stack.push(t.to_i);
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
		end
	end
	def solve(expr)
		# TODO try to figure out where the boundaries are.
		# e.g. "sin(2*5)" is not s*i*n(2*5), unfortunately, but abc might be a*b*c.
		# and 25 is not 2*5
		
		expr=expr.gsub(/\s+/,""); # remove all whitespace
		expr=expr.split(/\b/);    # split into an array by word boundaries (for now)

		$console.debug("Expression: #{expr}");

		post=infix2postfix(expr);

		return calcpostfix(*post);
	end
	def infix2postfix(input)
		$console.log("Converting infix to postfix...");
		
		output=[];
		operatorstack=[];

		input.each do |a|
			$console.debug(a);
			# if a is a number
			if numeric? a
				output.push(a);
			else
				# if a is an operator
				if $operators.respond_to? a
					$console.log("Pushing #{a}!");
					output.push(*operatorstack);
					operatorstack=[];
					operatorstack.push(a);
				else
					$console.error("Syntax error: '#{a}' was not expected");
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
