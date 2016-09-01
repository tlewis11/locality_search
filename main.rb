#need to write tests
#require "minitest/autorun"

#class TestMe < Minitest::Unit::TestCase
#
#    def setup
#        @document = 'mytestdoc.txt'
#    end
#
#    def test_file_is_readable
#        assert_equal 1, 1
#    end
#end
#


#need to only get text documents
#get all documents in a directory
#for each document, find the two search terms, 
#tell if the two search terms occur within N words of each other in the document
#return yes or no if this document has the terms in the designated locality


#ingest all words in file into an array
#does this preserve the order?
def file_to_array(filepath)
   
    contents = IO.readlines(filepath).map{|line| line.split()}
    words = contents.flatten
    return words
end

def get_positions(term_array, term_one, term_two)
    term_one_array = term_array.each_index.select{|i| term_array[i] == term_one}
    term_two_array = term_array.each_index.select{|i| term_array[i] == term_two}
    return term_one_array, term_two_array
end

def compare_positions(term_one_pos, term_two_pos, locality_factor)
    term_one_pos.any?{|index| 
                term_two_pos.any?{|second_index| 
                        (second_index - index).abs <= locality_factor 
                } 
    }
end

def searchDocument(document_path, term_one, term_two, locality_factor=2)
    contents = file_to_array(document_path)
    term_one_pos, term_two_pos = get_positions(contents, term_one, term_two) 
    compare_positions(term_one_pos, term_two_pos, locality_factor)
end

puts searchDocument('test.txt', 'Python', 'thing')
