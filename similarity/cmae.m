function [ score ] = cmae( I, J )

    score = 1 - mean(abs(I(:)-J(:)));
    
end

