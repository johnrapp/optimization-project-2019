%% Test 1

f = @(x) x(1) + x(2);

g_k{1} = @(x) -x(1);
g_k{2} = @(x) -x(2);

q = penalty(f, g_k, 1);

q([1;1])