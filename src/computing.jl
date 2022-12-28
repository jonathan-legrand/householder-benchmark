"""
Implicit and explicit product computation
"""


function make_explicit_mat(u)
    n = size(u)[begin]
    H = I(n) - 2 * (u * u') / (dot(u, u))
end

function explicit_vector_product(u, x)
    H = make_explicit_mat(u)
    return H * x
end

function implicit_vector_product(u, x)
    beta = 2 / (dot(u, u))
    return x - beta * u * (dot(u, x))
end

function explicit_matrix_product(A, u)
    H = make_explicit_mat(u)
    return A * H
end

function implicit_matrix_product(A, u)
    beta = 2 / (dot(u, u))
    v = A * u
    return A - beta * v * u'
end
###

