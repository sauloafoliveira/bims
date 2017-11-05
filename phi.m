function [ descr, surfFeatures ] = phi( I ) 
%PHI Summary of this function goes here
%   Detailed explanation goes here
    
    if size(I, 3) > 1
        G = rgb2gray(I);
        surfFeatures = detectSURFFeatures(G);
        descr = round(surfFeatures.Location);
    else
        surfFeatures = detectSURFFeatures(I);
        descr = round(surfFeatures.Location);
    end
end

