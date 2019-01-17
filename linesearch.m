function [lambda, No_of_iterations] = linesearch(func, x, d)

    f = @(lambda) func(x + lambda * d);
    
    a_0 = 0;
    b_0 = 1.0e+5;
    tol = 1.0e-10;
    
    [a, b, No_of_iterations] = golden_section(f, a_0, b_0, tol);
    
    lambda = (a + b) / 2;
    
    if isnan(func(x+lambda*d)) || func(x+lambda*d) > func(x)
        error('Bad job of the line search!')
    end
end

function [a, b, No_of_iterations] = golden_section(F, a_0, b_0, tol)
    alpha = (sqrt(5) - 1) / 2;
 
    a = a_0;
    b = b_0;
    
    reuse_lambda = false;
    reuse_mu = false;
    
    No_of_iterations = 0;

    while abs(a - b) >= tol
        No_of_iterations = No_of_iterations + 1;
        
        if not(reuse_lambda)
            lambda = a + (1 - alpha)*(b - a);
            f_lambda = F(lambda);
        end
        if not(reuse_mu)
            mu = a + alpha*(b - a);
            f_mu = F(mu);
        end
        
        if f_lambda > f_mu
            % Case 1
            a = lambda;
            
            reuse_lambda = true;
            reuse_mu = false;
            lambda = mu;
            f_lambda = f_mu;
        else
            % Case 2
            b = mu;
            
            reuse_mu = true;
            reuse_lambda = false;
            mu = lambda;
            f_mu = f_lambda;
        end
    end
end