function [lambda, No_of_iterations] = linesearch(func, x, d)

    F = @(lambda) func(x + lambda .* d);
    
    [lambda, No_of_iterations] = armijo(F);
    
    if isnan(func(x+lambda*d))
        error('Line search is NaN!')
    elseif func(x+lambda*d) > func(x)
        error('Line search did no good!')
    end
end

function [lambda, No_of_iterations] = armijo(F)

    alpha = 2;
    epsilon = 0.1;    
    lambda_0 = 1;

    max_iterations = 500;
    
    F_0 = F(0);
    [lambda, No_of_iterations] = find_suitable_lambda(F, lambda_0, F_0, alpha, max_iterations);
    
    derivative_0 = derivative(F, 0, lambda);

    T = @(lambda) F_0 + epsilon*lambda*derivative_0;
    
    while No_of_iterations < max_iterations
        No_of_iterations = No_of_iterations + 1;
        
        below_tangent = F(lambda) <= T(lambda);
        too_small = F(alpha*lambda) <= T(alpha*lambda);

        if below_tangent && not(too_small)
            break;
        end

        if not(below_tangent)
            lambda = lambda / alpha;
        elseif too_small
            lambda = lambda * alpha;
        end
    end
    
    if No_of_iterations == max_iterations
        error('Too long time in line search!')
    end

end

function [lambda, No_of_iterations] = find_suitable_lambda(F, lambda, F_0, alpha, max_iterations)
    No_of_iterations = 0;
    
    was_bigger = F(lambda) > F_0;
    
    while (isnan(F(lambda)) || F(lambda) > F_0) && No_of_iterations < max_iterations
       lambda = lambda / alpha;
       No_of_iterations = No_of_iterations + 1; 
    end
    
    if was_bigger
        return;
    end

    while F(lambda) < F_0 && No_of_iterations < max_iterations
        lambda = lambda * alpha;
        No_of_iterations = No_of_iterations + 1;
    end
    
    
    if No_of_iterations == max_iterations
        error('Too long time in line search!')
    end
end

function dy = derivative(F, x, suitable_lambda)
    h_0 = 1e-6;
    h = suitable_lambda * h_0;
    
    dy = (F(x + h) - F(x - h))/(2*h);
    
    if (dy > 0)
        dy = 0;
    end
end
