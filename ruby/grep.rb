#!/usr/bin/ruby

while line = STDIN.gets
    puts line if line.match ARGV[0]
end
