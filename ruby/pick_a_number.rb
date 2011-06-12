#!/usr/bin/ruby

lowerBound = 1
upperBound = 10

number = rand(upperBound - lowerBound) + lowerBound + 1
puts "Pick a number between #{lowerBound} and #{upperBound}."

while (guess = gets.to_i) && (guess != number)
    puts "Lower..."  if guess > number
    puts "Higher..." if guess < number
end

puts "You win!"
