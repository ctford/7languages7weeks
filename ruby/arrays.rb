#!/usr/bin/ruby

require 'enumerator'

# Print out 16 numbers, four at a time, using each_slice.
(1..16).each_slice(4).each do |slice| 
    puts slice.inject {|a, b| "#{a}, #{b}"} 
end
