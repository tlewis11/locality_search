#need to write tests
#require "./main"
#require "minitest/autorun"

#puts searchDocument 'truedoc.txt', 'Python', 'Ruby'

class LocalitySearchTests < Minitest::Unit::TestCase

   def setup
        @true_document = 'truedoc.txt'
        @false_document = 'falsedoc.txt'
        @search_term_one = "Python"
        @search_term_two = "Ruby"
        @multiline_document = 'multiline.txt'
    end

    def test_positive_document  
        result_bool = searchDocument @true_document, @search_term_one, @search_term_two
        assert(result_bool)
    end

    def test_mutliline_document  
        result_bool = searchDocument @multiline_document, @search_term_one, @search_term_two, 3
        assert(result_bool)
    end


    def test_false_document  
        false_result_bool = searchDocument @false_document, @search_term_one, @search_term_two
        assert(not(false_result_bool), msg="False document did not fail")

    end

end

