%% Test 1

a=-10; % try a = 2, a = -2 too, then a = 5 and -5, then a = 10 and -10
f=@(x) (1 - 10^a*x).^2;

a_0 = 0;
b_0 = 1000000;

x = 0;
d = 1;
[lambda, No_of_iterations] = linesearch(f, x, d)

ls = a_0:1:b_0;
plot(ls, f(x + ls*d))
hold on
plot(ls, 7*10^(1)*(ls >= lambda - 0.1 & ls <= lambda + 0.1))
hold off

%% Test 2
[lambda_1, No_of_iterations] = linesearch(@test_func,[0;0],[1;0])
test_func([0;0] + lambda_1*[1;0])
[lambda_2, No_of_iterations] = linesearch(@test_func,[0;0],[0;1])
test_func([0;0] + lambda_2*[0;1])

[lambda_3, No_of_iterations] = linesearch(@test_func,[lambda_1;0],[0;1])
test_func([lambda_1;0] + lambda_3*[0;1])
