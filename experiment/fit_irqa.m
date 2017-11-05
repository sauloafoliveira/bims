function [ metrics, y, theta  ] = fit_irqa( x, mos )

    equation = 'b1 * (0.5 - (1 + exp(b2 * (x- b3))) ^ -1) + b4 * x + b5';
    model = fittype(equation, 'coefficients',{'b1','b2','b3','b4','b5'});

    fitted_model = fit(x, mos, model);
    
    theta = zeros(1, 4);
    
    
    % extract fitted params
    theta(1) = fitted_model.b1;
    theta(2) = fitted_model.b2;
    theta(3) = fitted_model.b3;
    theta(4) = fitted_model.b4;
    theta(5) = fitted_model.b5;
    
    y = logit(x, theta);
    
    metrics = struct('rmse', rmse(mos, y), ...
                     'lle',  pearson(mos, y), ...
                     'srcc', spearman(mos, y), ...
                     'or',   outlier_ratio(y));
end

function [v] = rmse(a, b)
    v = sqrt( mean( (a(:) - b(:)) .^2 ) );
end

function [v] = pearson(a, b)
    v = corr(a(:), b(:));
end

function [v] = spearman(a, b)
    v = corr(a(:), b(:), 'type', 'Spearman');
end


function [v] = outlier_ratio(x)
    s = 2 * std(x(:));
    m = mean(x(:));
    outlier = (x < (m - s)) | (x > (m + s));
    
    if any(outlier)
        v = sum(outlier) ./ numel(x);
    else
        v = 0;
    end
    
    
end


function [v] = logit(x, theta)
     v = theta(1) .* (0.5 - (1 + exp(theta(2) .* (x - theta(3)))) .^ -1);
     v = v + theta(4) .* x + theta(5);
end
