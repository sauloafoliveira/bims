function [score] = mul(a_1, a_2, beta, rho)
    score = prod([a_1, a_2, beta, rho], 2);
end