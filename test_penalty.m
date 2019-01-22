%% Test 1

f = @(x) x(1) + x(2);

g_k{1} = @(x) -x(1);
g_k{2} = @(x) -x(2);

h_k{1} = @(x) x(1)^2 + x(2)^2 - 1;

q = penalty(f, g_k, h_k, 1);

q([1/sqrt(2);1/sqrt(2)])