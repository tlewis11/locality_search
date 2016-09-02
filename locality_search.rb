#!/usr/bin/env ruby
require 'optparse'
require 'json'


#=====================================================================

def file_to_array(filepath)
    #reads the contents of the file into an array, resulting array
    #contains all words in document in order
   
    contents = IO.readlines(filepath).map{|line| line.split()}
    words = contents.flatten
    return words
end

#=====================================================================

def get_positions(term_array, term_one, term_two)
    #search the term_array for for term_one and term_two. The indexes of all
    #occurrences are populated into two arrays.  The arrays are then 
    #returned.

    term_one_array = term_array.each_index.select{|i| term_array[i] == term_one}
    term_two_array = term_array.each_index.select{|i| term_array[i] == term_two}
    return term_one_array, term_two_array
end

#=====================================================================

def compare_positions(term_one_pos, term_two_pos, locality_factor)
    #takes two arrays of positions, for each position in first array, 
    #subtracts each position from second array. If the difference falls 
    #within the locality_factor, this is considered a match.  

    match = term_one_pos.any?{|index| 
                term_two_pos.any?{|second_index| 
                        (second_index - index).abs <= locality_factor 
                } 
    }
    return match
end

#=====================================================================


def searchDocument(document_path, term_one, term_two, locality_factor=2)
    #returns true if the two terms are found in the document close to each other
    #to be close to each other, they must be found within a [locality_factor] terms 
    # of each other
    contents = file_to_array(document_path)
    term_one_pos, term_two_pos = get_positions(contents, term_one, term_two) 
    return compare_positions(term_one_pos, term_two_pos, locality_factor)
end

#=====================================================================

def find_matching_docs_in_directory(term_one, term_two, directory=".", locality_factor=2)

    #selects all files in the given directory, then filters by 

    all_files = Dir.entries(directory).select{|entry| File.file?(entry)}

    matched_files = all_files.select{|filename| searchDocument(filename, term_one, term_two, locality_factor)}

    return matched_files

end

#=====================================================================




options = {}

OptionParser.new do |opts|

  opts.on("-d", "--directory [DIR]", "directory to search") do |d|
    options[:directory] = d
  end
end.parse!

usage = "Usage: locality_search.rb [options] TERMONE TERMTWO"

if ARGV.length != 2
    abort(usage)
end 

term_one = ARGV[0]
term_two = ARGV[1]

if options[:directory].nil?
    directory_to_search = '.'
else
    directory_to_search = options[:directory]
end

if not File.directory?(directory_to_search)
    abort("#{options[:directory]} is not a directory")
end

if options[:test]
    require 'minitest/autorun'
    require './test'
end

puts JSON.pretty_generate(find_matching_docs_in_directory(term_one, term_two))
