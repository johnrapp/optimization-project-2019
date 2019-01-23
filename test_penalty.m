%% Test 1

f = @(x) x(1)^2 + x(2)^2 + x(3)^2 + x(4)^2 +x(5)^2;

%g_k{1} = @(x) -x(1);
%g_k{2} = @(x) -x(2);
g_k = {
    @(x) -x(1)
    @(x) -x(2)
}

h_k{1} = @(x) x(1)^2 + x(2)^2 - 1;


mu = 1;

q = penalty(f, g_k, h_k, mu);

q([1/sqrt(2);1/sqrt(2)])


%% min exp(...)

f = @(x) exp(x(1) * x(2) * x(3) * x(4) * x(5));

g_k = {};

h_k{1} = @(x) x(1)^2 + x(2)^2 + x(3)^2 + x(4)^2 +x(5)^2;
h_k{2} = @(x) x(2) * x(3) - 5 * x(4) * x(5);   
h_k{3} = @(x) x(1)^3 + x(3)^3 + 1;

mu = 1;

start = [-2; 2; 2; -1; -1];

%for k = 1:5 
   q = penalty(f, g_k, h_k, mu);
   
   [x, No_of_iterations] = nonlinearmin(q, start, 'DFP', 1.0e-6, 0)
   
   mu = mu * 10 ;

%end

%% Exercice 9.3
f = @(x) exp(x(1)) + x(1)^2 + x(1)*x(2);

g_k = {};
h_k = {@(x) 1/2*x(1) + x(2) - 1};

mu = 4;
x = [0;0];

for k = 1:5
    q = penalty(f, g_k, h_k, mu);
    [x, No_of_iterations] = nonlinearmin(q, x, "DFP", 1.0e-6, 0)
    h_k{1}(x)
    
    mu = mu * 5;
end