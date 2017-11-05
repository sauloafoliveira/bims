function [ S, Smap ] = fsppm( I, h, Z )
%FSPPM Summary of this function goes here
%   Detailed explanation goes here
    
    if size(I, 3) > 1
        I = rgb2gray(I);        
    end
    
    W = detectPrototypes(I);
    Q = unique(W);
    
    size_I = size(I);
    
    S = zeros( size_I );
    
    if nargin < 2
        h = 9;
    end
    
    if nargin < 3 % only compute Z if necessary. 
        Z = phi( I );
    end
    
    for i = 1:length(Q)
        [x_j, y_j] = find(W == Q(i));
        
        z = mean([y_j, x_j], 1);
        
        p = parzen(z, Z, h);
        
        j = sub2ind(size_I, x_j, y_j);
        
        S(j) = p;
    end
    
    S = uint8(255 * mat2gray(S));
    
    %S = imfilter(S, fspecial('average', h)); %if required
    
    Smap = ind2rgb(S, parula(255));
end


function [W] = detectPrototypes(I)
    W = imclose(watershed(I), ones(3));
end

function [pd] = parzen(x, X, h)
    d = length(x);
    const =  1 ./ ((2 * pi) .^ (d/2) .* h .^ d); 
    u  = pdist2(x, X);
    pd = bsxfun(@rdivide, -u, (2 *  h .^ 2)');
    pd = mean(bsxfun(@times, exp(pd'), const));
    
end