function [score] = avg(a_1, a_2, beta, rho)
    score = mean([a_1, a_2, beta, rho], 2);
end