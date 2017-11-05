function [score] = lin(a_1, a_2, beta, rho)
    W = [0   25.5234    2.7817   46.8221]'; % my weights
    score = [a_1, a_2, beta, rho] * W;
end