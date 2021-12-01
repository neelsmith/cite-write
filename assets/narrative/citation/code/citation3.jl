# This file was generated, do not modify it. # hide
import CitableBase: urncontains

function urncontains(u1::MyIsbn, u2::MyIsbn)
    u1 == u2
end
@show urncontains(example, example2)