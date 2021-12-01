# This file was generated, do not modify it. # hide
using CitableBase
struct MyIsbn 
    isbnstr::AbstractString
end
example =  MyIsbn("urn:isbn:022661283X")
@show example.isbnstr