%% Test 1

f = @(x) x(1) + x(2);

%g_k{1} = @(x) -x(1);
%g_k{2} = @(x) -x(2);
g_k = {}

h_k{1} = @(x) x(1)^2 + x(2)^2 - 1;

mu = 1;

q = penalty(f, g_k, h_k, mu);

q([1/sqrt(2);1/sqrt(2)])

%% Exercice 9.3
f = @(x) exp(x(1)) + x(1)^2 + x(1)*x(2);

f_2 = @(x, y) exp(x) + x.^2 + x.*y;

g_k = {};
h_k = {@(x) 1/2*x(1) + x(2) - 1};

mu = 0.01;
start = [0;0];

%for k = 1:5
    q = penalty(f, g_k, h_k, mu);
    %[X,Y] = meshgrid(-10:0.5:10,-10:0.5:10);
    %[X,Y] = meshgrid(-2:1:2,-2:1:2);
    %surf(X,Y)
    ezplot(q)
    %[x, No_of_iterations] = nonlinearmin(q, start, "DFP", 1.0e-6, 0)
    
%    mu = mu * 10;
%end

