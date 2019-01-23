function [lambda, No_of_iterations] = linesearch(func, x, d)

    f = @(lambda) func(x + lambda .* d);
    
    [lambda, No_of_iterations] = armijo(f);
    
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

    max_iterations = 5000;
    
    F_0 = F(0);
    [lambda, No_of_iterations] = find_suitable_lambda(F, lambda_0, F_0, alpha, max_iterations);
    
    derivative_0 = derivative(F, 0, lambda);

    T = @(lambda) F_0 + epsilon*lambda*derivative_0;
    
    while No_of_iterations <= max_iterations
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
    
    while (isnan(F(lambda)) || F(lambda) > F_0) && No_of_iterations <= max_iterations
       lambda = lambda / alpha;
       No_of_iterations = No_of_iterations + 1; 
    end
    
    if was_bigger
        return;
    end

    while F(lambda) <= F_0 && No_of_iterations <= max_iterations
        lambda = lambda * alpha;
        No_of_iterations = No_of_iterations + 1;
    end
end

function dy = derivative(F, x, suitable_lambda)
    h_0 = 1e-6;
    h = suitable_lambda * h_0;
    
    dy = (F(x + h) - F(x - h))/(2*h);
    
    if (isnan(dy))
        error("NaN derivative");
    end
    
    if (dy > 0)
        dy = 0;
    end
end

% function [lambda, No_of_iterations] = linesearch(func,x,d)
%  
% %The one-dimensional function defined by the search direction d
% F=@(lambda)func(x+lambda*d);
%  
% %Parameters 0 < epsilon < 1 and alpha > 1 used in Armijo's rule
% epsilon = 0.1;
% alpha = 2;
%  
% %Initial step length
% lambda = 1; 
%  
% %Calculates F(0) only once to save time 
% F0 = F(0); 
%  
% %Definition of derivative
% df=@(h)(F(h)-F(-h))/2/h;
%  
% %Find a reasonable h to calculate F'(0) by finding an 
% % approximation of lambda that satisfy F(lambda)=F(0)
%  
% No_of_iterations=0;
% maxIters = 1000; %To prevent the algorithm from getting stuck in a loop
%  
% while isnan(F(lambda)) || F(lambda)>F0 && No_of_iterations<= maxIters
%    lambda = lambda/alpha;
%    No_of_iterations = No_of_iterations+1; 
% end
%  
% while F(lambda) <= F0 && No_of_iterations<= maxIters
%     lambda=lambda*alpha;
%     No_of_iterations=No_of_iterations+1;
% end
%  
% h=1e-6*lambda; % h is a small multiple of lambda
% Fprime0=df(h); % calculates F'(0) using the previously defined function
% h
% %Condition to make sure the derivative is not positive
% if Fprime0 > 0
%     Fprime0 = 0;
% end
% %The function defined in Armijo's rule
% T=@(lambda)F0 + epsilon*lambda*Fprime0;
%  
% 
%  
% %First condition in Armijo's rule using lambda from the previous 
% %approximation as initial step length 
% while F(lambda) > T(lambda) && No_of_iterations<= maxIters  
%     lambda = lambda/alpha;
%     No_of_iterations = No_of_iterations+1;
% end
%  
% %Second condition in Armijo's rule
% while F(alpha*lambda) < T(alpha*lambda) && No_of_iterations<= maxIters
%     lambda = lambda*alpha;
%     No_of_iterations = No_of_iterations+1;
% end
%  
% if isnan(func(x+lambda*d)) || func(x+lambda*d)>func(x)
%  error('Bad job of the line search!')
% end
%  
% end