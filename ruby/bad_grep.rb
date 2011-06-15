#!/usr/bin/ruby

# This doesn't work, because if there are command-line arguments, gets tries to
# open them as files and read from them!

# According to http://www.ruby-doc.org/core/classes/Kernel.html#M001404, gets
# "returns (and assigns to $_) the next line from the list of files in ARGV
# (or $*), or from standard input if no files are present on the command line."

while line = gets
    puts line if line.match ARGV[0]
end
