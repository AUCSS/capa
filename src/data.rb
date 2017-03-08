#
# For handling data between modules
#

class DataHandler
	class DataKeeper
		def initialize(o={})
			@data=o;
		end
		def [](id)
			return @data[id.to_sym];
		end
	end


	def initialize()
		@keepers={};
	end

	def [](id)
		$console.warn("Trying #{id}");
		if (@keepers.key? id)
			$console.warn("ID #{id} was found");
		else
			$console.warn("ID #{id} not found, creating a new entry");
			# TODO: seek from a file to put on a hash
			# Preferably JSON.
			# Yes.
			@keepers[id]=DataKeeper.new();
		end
	end
end
