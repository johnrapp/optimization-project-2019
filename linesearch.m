function [lambda, No_of_iterations] = linesearch(func, x, d)

    f = @(lambda) func(x + lambda * d);
    
    [lambda, No_of_iterations] = armijo(f);
    
    if isnan(func(x+lambda*d)) || func(x+lambda*d) > func(x)
        error('Bad job of the line search!')
    end
end

function [lambda, No_of_iterations] = armijo(F)

    beta = 2;
    epsilon = 0.1;
    
    lambda_0 = 1;
    alpha = 2;
    
    lambda = lambda_0;

    F_0 = F(0);
    derivative_0 = derivative(F, 0);

    %if (derivative_0 > 0)
    %    derivative_0 = 0;
    %end

    T = @(lambda) F_0 + epsilon*lambda*derivative_0;

    No_of_iterations = 0;
    
    while 1
        No_of_iterations = No_of_iterations + 1;
        
        below_tangent = F(lambda) <= T(lambda);
        too_small = F(alpha*lambda) <= T(alpha*lambda);

        if below_tangent && not(too_small)
            break;
        end

        if not(below_tangent)
            lambda = lambda / beta;
        elseif too_small
            lambda = lambda * beta;
        end

    end

end

function dy = derivative(F, x)
    h = 1.e-60;
    dy = (F(x+h) - F(x-h))/(2*h);
end