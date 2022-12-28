"""
Functions that get time
"""

function vect_gettimes(n::Int)
    u = rand(n)
    x = rand(n)
    texplicit = @elapsed explicit_vector_product(u, x)
    timplicit = @elapsed implicit_vector_product(u, x)
    return timplicit, texplicit
end

function mat_gettimes(n::Int)
    u = rand(n)
    A = rand(n, n)
    texplicit = @elapsed explicit_matrix_product(A, u)
    timplicit = @elapsed implicit_matrix_product(A, u)
    return timplicit, texplicit
end

