function [ scores ] = nlin( a_1, a_2, beta, rho )
%NLIN Summary of this function goes here
%   Detailed explanation goes here
    
    load('nlin_params');
    
    input =  [ a_1, a_2, beta, rho];
    scores = predict_rvm(input, xdata, PARAMETER, HYPERPARAMETER, basisWidth );
end


function [D2] = distSquared(X,Y)
%
nx	= size(X,1);
ny	= size(Y,1);
%
D2 = (sum((X.^2), 2) * ones(1,ny)) + (ones(nx, 1) * sum((Y.^2),2)') - ...
     2*X*Y';

end

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

