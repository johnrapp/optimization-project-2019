%% Test 1

f = @(x) x(1) + x(2);

g_k{1} = @(x) -x(1);
g_k{2} = @(x) -x(2);

epsilon = 1;

q = barrier(f, g_k, epsilon);

q([1/sqrt(2);1/sqrt(2)])
