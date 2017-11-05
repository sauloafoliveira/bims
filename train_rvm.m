function [ PARAMETER, HYPERPARAMETER, err ] = train_rvm(  X, Y, basisWidth )
%TRAIN_RVM Summary of this function goes here
%   Detailed explanation goes here

    addpath('rvm/');

    iterations = 500;
    dimension = size(X, 2);
    basisWidth	= basisWidth^(1/dimension);

    C	= X;
    BASIS	= exp(-distSquared(X,C)/(basisWidth^2));

    OPTIONS		= SB2_UserOptions('iterations',iterations,...
                                  'diagnosticLevel', 2,...
                                  'monitor', 10);

    SETTINGS	= SB2_ParameterSettings();

    [PARAMETER, HYPERPARAMETER] = ...
        SparseBayes('GAUSS', BASIS, Y, OPTIONS, SETTINGS)

    M			= size(BASIS,2);
    w_infer						= zeros(M,1);
    w_infer(PARAMETER.Relevant)	= PARAMETER.Value;
    err = mean((BASIS * w_infer - Y) .^2);
end

