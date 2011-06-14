#---
# Excerpted from "Seven Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/btlang for more book information.
#---
module ActsAsCsv
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end
  
  module InstanceMethods
    
    def read
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      @rows = []
      file.each do |row|
        map = {} 
        elements = row.chomp.split(', ')
        elements.each_with_index {|item, index| map[@headers[index]] = item}
        @rows << (MethodMap.new map)
      end
    end
    
    attr_accessor :headers, :csv_contents
    
    def initialize
      read 
    end

    def each 
      @rows.each {|row| yield row} 
    end

  end

end

class RubyCsv  # no inheritance! You can mix it in
  include ActsAsCsv
  acts_as_csv
end

class MethodMap 
  def initialize(map) 
    @map = map
  end
  def method_missing key 
    @map[key.to_s]
  end
end

map = {'foo' => 'bar'}
methodMap = MethodMap.new map
puts methodMap.foo

m = RubyCsv.new
m.each {|row| puts row.country}
