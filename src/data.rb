#
# For handling data between modules
#

require("json");

class DataHandler
	class DataKeeper < Hash
		# Getters and setters transform strings into symbols
		def [](a,*b)
			super(a.to_sym,*b);
		end
		def []=(a,*b)
			super(a.to_sym,*b);
		end
		def reverse_merge(obj)
			_current=self.clone();
			self.update(obj);
			self.update(_current);
		end
	end

	def initialize()
		@keepers={};
	end

	def [](id)
		$console.info("DATA: Trying #{id}");
		if (@keepers.key? id)
			$console.dump("ID #{id} was found");
			return @keepers[id];
		else
			$console.dump("ID #{id} not found, creating a new entry");
			current={};

			# TODO: seek from a file to put on a hash
			# Preferably JSON.
			# Yes.

			begin
				data=IO.read("data/#{id}.json");
				begin
					current=JSON.parse(data,:symbolize_names=>true);
					$console.info("Loaded file for #{id} (#{current})");
				rescue => err
					$console.error("Cannot parse JSON: #{err}");
				end
			rescue => err
				$console.info("Not loading file: #{err}");
			end

			@keepers[id]=DataKeeper.new().merge(current);
		end
	end

	def save()
		$console.log("DATA: Saving keepers...");
		# Save all of our files
		@keepers.each do |id,k|
			begin
				$console.dump("Saving #{k.to_json}");
				IO.write("data/#{id}.json",k.to_json);
			rescue => err
				$console.error("Cannot save keeper #{id}: #{err}");
			end
		end
	end
end
