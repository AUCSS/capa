#!/usr/bin/env ruby
o=ARGV.empty? ? [0,0]: ARGV[0].split(":").to_a
puts (Time.now+o[0].to_i*3600+(o[0][0]=="-"?-o[1].to_i*60: o[1].to_i*60)).strftime "%H:%M"