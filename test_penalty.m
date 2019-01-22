%% Test 1

f = @(x) x;

g_k{1} = @(x) -(x(1) + x(2) - 2);
g_k{2} = @(x) -(x(2) - x(1) - 0);

F = @(x, mu) f(x) + mu*penalty(g_k, x);