function [ XX ] = predict_rvm( X, R, PARAMETER, HYPERPARAMETER, basisWidth )
%PREDICT_RVM Summary of this function goes here
%   Detailed explanation goes here

    Xi = R(PARAMETER.Relevant, :);
    Wi = PARAMETER.Value;
    dimension = size(X, 2);
    basisWidth	= basisWidth^(1/dimension);
    BASIS = exp(-distSquared(X,Xi)/(basisWidth^2));
    XX = sum(bsxfun(@times, BASIS, Wi') + HYPERPARAMETER.beta, 2);

end

