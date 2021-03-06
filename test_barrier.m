%% Exercice 9.5
f = @(x) (x(1)-5)^2 + (x(2) - 3)^2;

g_k = {
    @(x) x(1) + x(2) - 3;
    @(x) -x(1) + 2*x(2) - 4;
};
epsilon = 1;
x = [0;0];

iterations = 0;

for k = 1:5
    q = barrier(f, g_k, epsilon);
    epsilon;
    [x, No_of_iterations] = nonlinearmin(q, x, "BFGS", 1.0e-6, 0);
    
    epsilon = epsilon / 10;
    
    iterations = iterations + No_of_iterations;
    
end

x
f(x)
iterations 