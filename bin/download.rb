#!/usr/bin/env ruby

# Arguments
case ARGV.length
  when 0: raise ArgumentError
  when 1: uri = ARGV[0] #< Commandline
  else    uri = ARGV[7] #< Uzbl handler
end

# Connect to subtle
begin
  require "subtle/subtlext"

  # Find sublet
  $s = Subtlext::Subtle.new.find_sublet("download")
rescue
  puts "Couldn't load subtlext: " + $!
end

# Trap signals
reset = lambda { $s.data = "" }

trap("INT",  reset)
trap("TERM", reset)
trap("PIPE", reset)

# Customization
dir     = "%s/downloads" % ENV["HOME"]
wget    = "/usr/bin/wget"
cookies = "--load-cookies=%s/cookies/rapidshare" % ENV["XDG_DATA_HOME"]
options = "--user-agent=Firefox --limit=700k -c"
command = "%s %s %s %s --progress=dot 2<&1" % [ wget, options, cookies, uri ]

# Fire up wget
begin
  Dir.chdir(dir)

  $s.data = "  |  0%  "

  IO.popen(command, "r") do |f|
    f.each do |l|
      if(l.match("([0-9]*%)\s+(.*)\s+(.*)$"))
        $s.data = "  |  %s@%s ~%s  " % [ $~[0], $~[1], $~[2] ] 
      end
    end
  end
 
  $s.data = "  |  100%  "
  sleep 2
rescue
  puts "Something went wrong: " + $!
end

# Tidy up
reset.call
