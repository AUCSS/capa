#
# Bot - talk to CAPA.
# Currently it's Wicton (more on that later)
#

require("./lib/wicton.rb");
$bot=Wicton.new();

def bot(input=nil)
	if (input==nil)
		return
	end
	return $bot.say(input);
end

def train(a,b)
	$console.warn("Training bot with '#{a}' and '#{b}'");
	$bot.train(a,b);
	return;
end
