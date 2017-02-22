a=ARGV;o=a.empty? ? [0,0]: a[0].split(":").to_a;puts (Time.now+o[0].to_i*3600+(o[0][0]=="-"?-o[1].to_i*60: o[1].to_i*60)).strftime "%H:%M"
