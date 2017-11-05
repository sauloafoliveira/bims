
function [y, w_infer2, PARAMETER, HYPERPARAMETER, DIAGNOSTIC] ...
    = saulo(X, Outputs, basisWidth)

iterations = 500;
dimension = size(X, 2);
%basisWidth	=  0.05;		% NB: data is in [0,1]
basisWidth	= basisWidth^(1/dimension);

C	= X;
BASIS	= exp(-distSquared(X,C)/(basisWidth^2));

OPTIONS		= SB2_UserOptions('iterations',iterations,...
							  'diagnosticLevel', 2,...
							  'monitor', 10);

SETTINGS	= SB2_ParameterSettings();

[PARAMETER, HYPERPARAMETER, DIAGNOSTIC] = ...
    SparseBayes('GAUSS', BASIS, Outputs, OPTIONS, SETTINGS)

M			= size(BASIS,2);
w_infer						= zeros(M,1);
w_infer(PARAMETER.Relevant)	= PARAMETER.Value;

y				= BASIS*w_infer;
w_infer2 = w_infer(w_infer ~= 0);