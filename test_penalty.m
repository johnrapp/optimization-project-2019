%% min exp(...)

f = @(x) exp(x(1) * x(2) * x(3) * x(4) * x(5));

g_k = {};

h_k{1} = @(x) x(1)^2 + x(2)^2 + x(3)^2 + x(4)^2 +x(5)^2 - 10;
h_k{2} = @(x) x(2) * x(3) - 5 * x(4) * x(5);   
h_k{3} = @(x) x(1)^3 + x(3)^3 + 1;

mu = 0.01;

x = [-2; 2; 2; -1; -1];

total_iterations = 0;
for k = 1:5 
   q = penalty(f, g_k, h_k, mu);
   
   [x, No_of_iterations] = nonlinearmin(q, x, 'BFGS', 1.0e-6, 1);
   
   mu = mu * 10;
   
   total_iterations = total_iterations + No_of_iterations;

end
x
f(x)
total_iterations

%% Exercice 9.3
f = @(x) exp(x(1)) + x(1)^2 + x(1)*x(2);

g_k = {};
h_k = {@(x) 1/2*x(1) + x(2) - 1};

mu = 4;
x = [0;0];

total_iterations = 0;
for k = 1:5
    q = penalty(f, g_k, h_k, mu);
    [x, No_of_iterations] = nonlinearmin(q, x, "BFGS", 1.0e-6, 0);
    
    mu = mu * 10;
    
    total_iterations = total_iterations + No_of_iterations;
end
x
f(x)
total_iterations