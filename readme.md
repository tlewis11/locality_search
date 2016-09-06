Locality searcher implemented in Ruby.  This is a command line utility to search a document for
two terms and determine whether the two terms appear in the document within a certain distance from each other. Given a directory, the locality searcher will output a list of the documents that meet the criterion of having the two given terms within the given distance.

Install and Use:

1. git clone https://github.com/tlewis11/locality_search
2. cd locality_search 
3. ./locality_search.rb Python Ruby -d someDirectoryToSearch -n 3

This will search someDirectoryToSearch and return a json encoded list of all the documents containing the terms Python and Ruby that occur within 3 words of each other

Usage: locality_search.rb [options] TERMONE TERMTWO
    -d, --directory [DIR]            directory to search. Default to current dir .
    -l, --locality-factor [N]        The distance within which the terms must appear.  Default is 2
    -t, --test                       Perform unit tests.  Exits after tests are complete.
    -h, --help                       print this help message
