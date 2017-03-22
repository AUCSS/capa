#
# Wicton in ruby!
# After all these years!
#
# I> Simple logic for choosing an answer to a question
# I> Stored in a JSON file for easy lookup
# I> We also process the words - count them together in a few ways (case, incase, norepeat)
# I> When we have a vast database of words, we can start ignoring the most common ones, develop an "interest" and some more interesting algorithms for choosing an answer

$algorithms=[];

require("./lib/wicton/PerfectMatch.rb");
require("./lib/wicton/PerfectMatchCaseInsensitive.rb");

class Wicton
	def initialize()
		@data=$data["wicton"];
	end
	def say(string)
		$console.log("Wicton: #{string}");
		$console.info("Calculating the best response using our algorithms...");

		results=[];
		$algorithms.each do |a|
			$console.log("Algorithm '#{a.id}'...");
			a.solve(string).each do |r|
				$console.dump("#{r}");
				$console.log("##{a.id}: confidence: #{r[:confidence]}, response: #{r[:response]}");
				# Todo: check that confidence is always 0..1, response is always string, error otherwise
				results.push(r);
			end
		end

		$console.info("Choosing the best response...");
		if (results.size==0)
			$console.warn("No results from any algorithm!");
			return;
		else
			# Sort by biggest confidence
			$console.verbose("Sorting confidences...");
			results=results.sort_by{|r| r[:confidence]}.reverse;
			$console.verbose("Summing confidences together...");
			sum=results.inject(0){|sum,n| sum+n[:confidence]};
			$console.verbose("Randomizing a confidence value...");
			rndoriginal=rnd=rand*sum;

			$console.dump("Result dump follows:");
			$console.dump(results.join);

			# Loop through our array, stopping on the result
			results.each_with_index do |r,i|
				rnd-=r[:confidence];
				$console.dump(rnd);
				if (rnd<=0)
					# PICK ME
					$console.debug("Result index: #{i}");
					$console.debug("Biggest confidence: #{results[0]}");
					$console.debug("Confidence skip: #{rndoriginal} of #{sum}");
					$console.info("Returning #{r[:result]}");
					return r[:result];
				end
			end
		end
	end
	def train(question,answer)
		$console.info("Training Wicton: #{question} -> #{answer}");
		$algorithms.each do |a|
			$console.log("Algorithm '#{a.id}'...");
			a.train(question,answer);
		end
	end
end
