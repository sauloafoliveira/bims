function [ score ] = bims( I, J, h, sim_metric, fusion )
%BIMS Summary of this function goes here
%   Detailed explanation goes here
    
    addpath('.');
    addpath('fusion');
    addpath('similarity');

    if size(I, 3) > 1
        I = rgb2gray(I);
    end
    
    if size(J, 3) > 1
        J = rgb2gray(J);
    end
    
    [P_I, KP_I] = phi(I);
    
    [P_J, KP_J] = phi(J);
    
    % M = M_I = M_J for features
    [M_I, M_J]  = match_kp(KP_I, KP_J, I, J); 


    S_I  = fsppm(I, h, P_I);
    
    S_J  = fsppm(J, h, P_J);
    
    S_I_M  = fsppm(I, h, M_I);
    
    S_J_M  = fsppm(J, h, M_J);

    a_1   = feval(sim_metric, S_I, S_I_M);
    a_2   = feval(sim_metric, S_J, S_J_M);

    beta  = matching_information(M_I, P_I, P_J);
    
    rho   = retargeting_ratio(I, J);

    score = feval(fusion, a_1, a_2, beta, rho);
    
end

function beta  = matching_information(M_I, P_I, P_J)
    beta = 2 * size(M_I, 1) / ( size(P_I, 1) + size(P_J, 1));
end


function [M_I, M_J] = match_kp(KP_I, KP_J, I, J)
    [f1, kp1] = extractFeatures(I, KP_I);
    [f2, kp2] = extractFeatures(J, KP_J);

    pairs = matchFeatures(f1, f2, 'Method', 'NearestNeighborSymmetric');
    
    M_I = kp1(pairs(:, 1)).Location;
    M_J = kp2(pairs(:, 2)).Location;

end

function [rho] = retargeting_ratio(I, J)
    [M, N] = size(I);
    [m, n] = size(J);
    
    rho = min(M, m) * min(N, n) / ( max(M, m) * max(N, m));
end

