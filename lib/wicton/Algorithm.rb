#
# Base algorithm class
#
class Algorithm
        @@id=0;
	@@confidence=0.5;
	def id;@id end
	def initialize()
		@id=self.class.name+(@@id+=1).to_s;
                @data=$data[self.class.name];
	end
	def solve(question)
		if @data.key? question.to_sym
			return @data[question.to_sym].map {|a| {result:a, confidence:@@confidence}};
		else
			return [];
		end
	end
	def train(question,answer)
		if @data.key? question.to_sym
			@data[question.to_sym].push(answer);
		else
			@data[question.to_sym]=[answer];
		end
	end
end
